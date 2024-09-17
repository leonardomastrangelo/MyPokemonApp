import UIKit

class DetailsViewController: UIViewController {
    
    var id: Int?
    var pokemon: PokemonData?
    var pokemonManager = PokemonManager()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loader.startAnimating()
        nameLabel.isHidden = true
        heightLabel.isHidden = true
        weightLabel.isHidden = true
        
        pokemonManager.delegate = self
        if let pokemonId = id {
            pokemonManager.fetchPokemon(id: pokemonId)
        }
    }
}

//MARK: - PokemonManagerDelegate
extension DetailsViewController: PokemonManagerDelegate {
    
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonData) {
        DispatchQueue.main.async {
            self.pokemon = pokemon
            self.nameLabel.text = pokemon.name
            self.heightLabel.text = "Height: \(pokemon.height ?? 0)m"
            self.weightLabel.text = "Weight: \(pokemon.weight ?? 0)Kg"
            
            self.loader.stopAnimating()
            self.loader.isHidden = true
            
            self.nameLabel.isHidden = false
            self.heightLabel.isHidden = false
            self.weightLabel.isHidden = false
        }
    }
    
    // not used here
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {
    }
    
    func didFailWithError(error: Error) {
        self.loader.stopAnimating()
        self.loader.isHidden = true
        print("Failed to fetch Pokemon details: \(error)")
    }
}

