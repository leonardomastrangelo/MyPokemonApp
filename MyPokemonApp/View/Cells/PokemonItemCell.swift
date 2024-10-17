import UIKit

class PokemonItemCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var toggleFavoriteCallback: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.customFont(ofSize: Constants.FontSizes.f30)
    }
    
    func configure(text: String, isFavorite: Bool) {
        label.text = text.uppercased()
        contentView.backgroundColor = UIColor.systemOrange
        
        let starImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
        favoriteButton.setImage(starImage, for: .normal)
    }
    
    @IBAction func favoriteButtonTapped(_ sender: UIButton) {
        toggleFavoriteCallback?()
    }
    
}

