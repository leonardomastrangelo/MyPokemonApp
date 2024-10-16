import UIKit

class PokemonItemCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        label.font = UIFont.customFont(ofSize: Constants.FontSizes.f30)
    }
    
    func configure(text: String) {
        label.text = text.uppercased()
        contentView.backgroundColor = UIColor.systemOrange
    }
}

