import UIKit

class HomeViewController: UIViewController {
    
    var pokemonManager = PokemonManager()
    var pokemonList: [PokemonData] = []
    
    var offset = 0
    var isLoading = false
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        checkSettings()
        pokemonManager.delegate = self
        loadPokemonData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshLanguage()
        applyTheme(isDarkMode: UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey))
        tableView.reloadData()
    }
    
    // MARK: - Data Fetching
    func loadPokemonData() {
        guard !isLoading else { return }
        isLoading = true
        pokemonManager.fetchPokemonList(offset: offset)
    }
}

//MARK: - UI Setup
extension HomeViewController {
    private func setupUI() {
        configureAppTitle()
        configureTableView()
    }
    
    private func configureAppTitle() {
        appTitleLabel.font = UIFont.customFont(ofSize: 35)
        appTitleLabel.text = "Title".translated().uppercased()
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.cellIdentifier)
        addTableViewDetails()
    }
}

//MARK: - Language And Theme
extension HomeViewController {
    private func refreshLanguage() {
        appTitleLabel.text = "Title".translated().uppercased()
        tableView.reloadData()
    }
    
    private func applyTheme(isDarkMode: Bool) {
        let backgroundColor: UIColor = isDarkMode ? UIColor.black.withAlphaComponent(0.7) : UIColor.systemYellow.withAlphaComponent(0.7)
        let separatorColor: UIColor = isDarkMode ? UIColor.white : UIColor.black
        
        tableView.backgroundColor = backgroundColor
        tableView.separatorColor = separatorColor
    }
}

// MARK: - Settings Check
extension HomeViewController {
    private func checkSettings() {
        print("[IS PRODUCTION?] -> \(Environment.isProduction)")
        print("[CURRENT ENV] -> \(Environment.envName)")
        if Environment.isProduction == "NO" {
            print("[API BASE URL] -> \(Environment.apiBaseUrl)")
            print("[API KEY] -> \(Environment.apiKey)")
        }
    }
}

// MARK: - PokemonManagerDelegate
extension HomeViewController: PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {
        let dispatchGroup = DispatchGroup()
        var detailedPokemonList: [PokemonData] = []
        
        // Fetch detailed Pokemon data
        for pokemon in pokemonList {
            dispatchGroup.enter()
            pokemonManager.fetchPokemonByName(pokemonName: pokemon.name) { [weak self] detailedPokemon in
                guard self != nil else { return }
                if let detailedPokemon = detailedPokemon {
                    detailedPokemonList.append(detailedPokemon)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.updatePokemonList(with: detailedPokemonList)
        }
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print("Failed to fetch Pokemon list: \(error)")
        }
        isLoading = false
    }
    
    private func updatePokemonList(with detailedPokemonList: [PokemonData]) {
        self.pokemonList += detailedPokemonList.sorted(by: { $0.id ?? 0 < $1.id ?? 0 })
        self.offset += Constants.Network.limit
        self.isLoading = false
        self.tableView.reloadData()
        
    }
}

// MARK: - Navigation
extension HomeViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.TBView.homeToDetail,
           let detailVC = segue.destination as? DetailsViewController,
           let indexPath = sender as? IndexPath {
            let selectedPokemon = pokemonList[indexPath.row]
            detailVC.pokemon = selectedPokemon
            updateBackButtonTitle()
        }
    }
}
