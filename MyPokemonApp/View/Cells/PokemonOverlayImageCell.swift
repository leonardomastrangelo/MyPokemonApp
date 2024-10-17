import UIKit

class PokemonOverlayImageCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    
    var pokemonManager = PokemonManager()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(backgroundImage: UIImage, overlayImageURL: String) {
        backgroundImageView.image = backgroundImage
        
        pokemonManager.fetchPokemonImage(from: overlayImageURL) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.overlayImageView.image = image
            }
        }
    }
}
