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
        
        appTitleLabel.text = "title".translated()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.cellIdentifier)
        
        pokemonManager.delegate = self
        loadPokemonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshLanguage()
    }
    
    func refreshLanguage() {
        appTitleLabel.text = "title".translated()
        tableView.reloadData()
    }
    
    func loadPokemonData() {
        isLoading = true
        pokemonManager.fetchPokemonList(offset: offset)
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
        
        for pokemon in pokemonList {
            dispatchGroup.enter()
            pokemonManager.fetchPokemonByName(pokemonName: pokemon.name) { detailedPokemon in
                if let detailedPokemon = detailedPokemon {
                    self.pokemonList.append(detailedPokemon)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
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
        cell.label.text = "\(pokemonListItem.name.uppercased()) - \("Height".translated()): \(pokemonListItem.height ?? 0)m - \("Weight".translated()): \(pokemonListItem.weight ?? 0)Kg"
        
        return cell
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
