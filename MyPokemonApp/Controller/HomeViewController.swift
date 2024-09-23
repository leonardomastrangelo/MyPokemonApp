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
        
        appTitleLabel.text = Constants.appTitle
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: Constants.TBView.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.TBView.cellIdentifier)
        
        pokemonManager.delegate = self
        loadPokemonData()
    }
    
    func loadPokemonData() {
        isLoading = true
        pokemonManager.fetchPokemonList(offset: offset)
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
        cell.label.text = "\(pokemonListItem.name) - height: \(pokemonListItem.height ?? 0) - weight: \(pokemonListItem.weight ?? 0)"
        
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


