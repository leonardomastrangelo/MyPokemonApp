import UIKit

class HomeViewController: UIViewController {
    
    var pokemonManager = PokemonManager()
    var pokemonList: [PokemonData] = []
    
    var offset = 0
    var isLoading = false
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkSettings()
        
        appTitleLabel.font = UIFont.customFont(ofSize: 35)
        appTitleLabel.text = "Title".translated().uppercased()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.cellIdentifier)
        addTableViewDetails()
        
        pokemonManager.delegate = self
        loadPokemonData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshLanguage()
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        applyTheme(isDarkMode: isDarkMode)
    }
    
    func refreshLanguage() {
        appTitleLabel.text = "Title".translated().uppercased()
        tableView.reloadData()
    }
    
    func loadPokemonData() {
        isLoading = true
        pokemonManager.fetchPokemonList(offset: offset)
    }
    
    private func applyTheme(isDarkMode: Bool) {
        if isDarkMode {
            
            tableView.backgroundColor = UIColor.black
            tableView.separatorColor = UIColor.white
            
            tableView.visibleCells.forEach { cell in
                if let pokemonCell = cell as? PokemonCell {
                    pokemonCell.label.textColor = .white
                    pokemonCell.labelName.textColor = .white
                }
            }
        } else {
            tableView.backgroundColor = UIColor.systemYellow
            tableView.separatorColor = UIColor.black
            
            tableView.visibleCells.forEach { cell in
                if let pokemonCell = cell as? PokemonCell {
                    updateCellColors(cell: pokemonCell)
                }
            }
        }
    }
    
}

//MARK: - Check Settings
extension HomeViewController {
    func checkSettings() {
        print("[IS PRODUCTION?] -> \(Environment.isProduction)")
        print("[CURRENT ENV] -> \(Environment.envName)")
        if Environment.isProduction == "NO" {
            print("[API BASE URL] -> \(Environment.apiBaseUrl)")
            print("[API KEY] -> \(Environment.apiKey)")
        }
    }
}

// MARK: - Retrieving Pokemon List
extension HomeViewController: PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {
        let dispatchGroup = DispatchGroup()
        
        var detailedPokemonList: [PokemonData] = []
        
        for pokemon in pokemonList {
            dispatchGroup.enter()
            pokemonManager.fetchPokemonByName(pokemonName: pokemon.name) { detailedPokemon in
                if let detailedPokemon = detailedPokemon {
                    detailedPokemonList.append(detailedPokemon)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.pokemonList += detailedPokemonList.sorted(by: { $0.id ?? 0 < $1.id ?? 0 })
            self.offset += Constants.Network.limit
            self.isLoading = false
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print("Failed to fetch Pokemon list: \(error)")
        }
        isLoading = false
    }
}

// MARK: - Table View Building
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonListItem = pokemonList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.cellIdentifier, for: indexPath) as! PokemonCell
        
        cell.backgroundColor = UIColor.clear
        
        cell.label.text = "N°\(String(format: "%03d", pokemonListItem.id ?? 0))"
        cell.labelName.text = pokemonListItem.name.uppercased()
        
        updateCellColors(cell: cell)
        
        return cell
    }
    
    private func updateCellColors(cell: PokemonCell) {
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            cell.label.textColor = .white
            cell.labelName.textColor = .white
        } else {
            cell.label.textColor = .black
            cell.labelName.textColor = .black
        }
    }
}

//MARK: - Table View Layout
extension HomeViewController {
    func addTableViewDetails() {
        tableView.layer.cornerRadius = Constants.Sizes.pokeCornerRadius
        tableView.backgroundColor = UIColor.systemYellow
        tableView.layer.borderWidth = Constants.Sizes.pokeBorderWidth
        tableView.layer.borderColor = Constants.PokeColors.pokeGray
    }
}

// MARK: - Table View Actions
extension HomeViewController: UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        // very if the user is 100px away from the end of the list
        if position > contentHeight - frameHeight - 100 {
            if !isLoading {
                loadPokemonData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.TBView.homeToDetail, sender: indexPath)
    }
}

//MARK: - Navigation
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.TBView.homeToDetail {
            if let detailVC = segue.destination as? DetailsViewController,
               let indexPath = sender as? IndexPath {
                let selectedPokemon = pokemonList[indexPath.row]
                detailVC.pokemon = selectedPokemon
                
                updateBackButtonTitle()
            }
        }
    }
}
