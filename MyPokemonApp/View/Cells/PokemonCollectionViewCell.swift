import UIKit

class PokemonCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var pokemonNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleBackground()
    }
    
    func configure(with pokemon: PokemonData) {
        applyTheme()
        
        
        pokemonNameLabel.text = pokemon.capitalizedName
        
        if let imageURL = pokemon.sprites?.front_default {
            PokemonManager().fetchPokemonImage(from: imageURL) { [weak self] image in
                DispatchQueue.main.async {
                    self?.pokemonImageView.image = image
                }
            }
        }
    }
    
    private func applyTheme() {
        pokemonNameLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f22)
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            pokemonNameLabel.textColor = UIColor.white
            
        } else {
            pokemonNameLabel.textColor = UIColor.black
        }
    }
    
    func styleBackground() {
        bgImageView.layer.cornerRadius = bounds.size.width / 3.5
        bgImageView.layer.masksToBounds = true
    }
}
