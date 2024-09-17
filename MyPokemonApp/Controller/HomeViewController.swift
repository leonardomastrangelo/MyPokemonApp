import UIKit

class HomeViewController: UIViewController {
    
    var pokemonManager = PokemonManager()
    var pokemonList: [PokemonData] = []
    var id: Int = 1
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Title
        appTitleLabel.text = K.appTitle
        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: K.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: K.TBView.cellIdentifier)
        // Set PokemonManager delegate
        pokemonManager.delegate = self
        // Fetch Pokemon List
        pokemonManager.fetchPokemonList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == K.TBView.homeToDetail {
            if let detailVC = segue.destination as? DetailsViewController {
                detailVC.id = id
            } else {
                print("error changing route")
            }
        }
    }

}

//MARK: - Retrieving Pokemon List
extension HomeViewController: PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {
        DispatchQueue.main.async {
            self.pokemonList = pokemonList
            self.tableView.reloadData()
        }
    }
    
    // not used here
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonData) {
    }
    
    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print("Failed to fetch Pokemon list: \(error)")
        }
    }
}

//MARK: - Table View Building
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let pokemonListItem = pokemonList[indexPath.row]
        
        // creation cell
        let cell = tableView.dequeueReusableCell(withIdentifier: K.TBView.cellIdentifier, for: indexPath) as! PokemonCell
        cell.label.text = pokemonListItem.name
        
        return cell
    }
}

//MARK: - Table View Actions
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        id = indexPath.row + 1
        performSegue(withIdentifier: K.TBView.homeToDetail, sender: self)
    }
}

