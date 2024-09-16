import UIKit

class DetailsViewController: UIViewController {
    
    var id: Int?
    var pokemon: PokemonModel?
    var pokemonManager = PokemonManager()

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonManager.delegate = self
        pokemonManager.fetchPokemon(id: id ?? 1)
    }
}

//MARK: - Retrieving selected Pokemon
extension DetailsViewController: PokemonManagerDelegate {
    func didUpdatePokemon(_ pokemonManager: PokemonManager, pokemon: PokemonModel) {
        DispatchQueue.main.async {
            self.pokemon = pokemon
            self.nameLabel.text = pokemon.name
            self.heightLabel.text = "Height: \(pokemon.height)m"
            self.weightLabel.text = "Weight: \(pokemon.weight)Kg"
        }
    }
    
    func didFailWithError(error: any Error) {
        print(error)
    }
}
