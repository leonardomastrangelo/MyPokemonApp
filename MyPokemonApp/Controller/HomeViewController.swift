import UIKit

class HomeViewController: UIViewController {
    
    var pokemonManager = PokemonManager()
    var pokemonList: [PokemonData] = []
    
    @IBOutlet weak var appTitleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        appTitleLabel.text = Constants.appTitle
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.cellIdentifier)
        
        pokemonManager.delegate = self
        pokemonManager.fetchPokemonList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.TBView.homeToDetail {
            if let detailVC = segue.destination as? DetailsViewController,
               let indexPath = sender as? IndexPath {
                let selectedPokemon = pokemonList[indexPath.row]
                detailVC.pokemon = selectedPokemon
            }
        }
    }

}

// MARK: - Retrieving Pokemon List
extension HomeViewController: PokemonManagerDelegate {
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {
        self.pokemonList = []

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
            self.tableView.reloadData()
        }
    }

    func didFailWithError(error: Error) {
        DispatchQueue.main.async {
            print("Failed to fetch Pokemon list: \(error)")
        }
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
        cell.label.text = "\(pokemonListItem.name) - height: \(pokemonListItem.height ?? 0) - weight: \(pokemonListItem.weight ?? 0)"

        return cell
    }
}

// MARK: - Table View Actions
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: Constants.TBView.homeToDetail, sender: indexPath)
    }
}

