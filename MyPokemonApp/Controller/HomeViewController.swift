import UIKit

class HomeViewController: UIViewController {
    
    var pokemonListManager = PokemonListManager()
    var pokemonList: [PokemonListItem] = []
    
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
        // PokemonList
        pokemonListManager.delegate = self
        pokemonListManager.fetchPokemonList()
    }

}


//MARK: - Retrieving Pokemon List
extension HomeViewController: PokemonListManagerDelegate {
    func didUpdatePokemonList(_ pokemonListManager: PokemonListManager, pokemonList: PokemonListModel) {
        DispatchQueue.main.async {
            self.pokemonList = pokemonList.pokemonList
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        DispatchQueue.main.async {
            print(error)
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
        let selectedPokemon = pokemonList[indexPath.row]
        print(selectedPokemon.name)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
