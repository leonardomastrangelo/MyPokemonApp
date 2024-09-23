import UIKit

class DetailsViewController: UIViewController {
    
    var pokemon: PokemonData? 
    
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
        
        if let pokemon = pokemon {
            updateUI(with: pokemon)
        }
    }
    
    private func updateUI(with pokemon: PokemonData) {
        DispatchQueue.main.async {
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
}

//MARK: - PokemonManagerDelegate
extension DetailsViewController: PokemonManagerDelegate {
    
    func didUpdatePokemonList(_ pokemonManager: PokemonManager, pokemonList: [PokemonData]) {}
    
    func didFailWithError(error: Error) {
        self.loader.stopAnimating()
        self.loader.isHidden = true
        print("Failed to fetch Pokemon details: \(error)")
    }
}

