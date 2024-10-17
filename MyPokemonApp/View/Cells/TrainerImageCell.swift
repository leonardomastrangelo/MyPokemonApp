import UIKit

class TrainerImageCell: UITableViewCell {
    
    @IBOutlet weak var trainerImage: UIImageView!
    @IBOutlet weak var pokemonImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trainerImage.image = UIImage(named: "Trainer")
        pokemonImage.image = UIImage(named: "Audino")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
