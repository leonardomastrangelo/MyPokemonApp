import UIKit

class TrainerTitleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(title: String) {
        titleLabel.text = title
        titleLabel.textAlignment = .center
        applyTheme()
    }
    
    private func applyTheme() {
        titleLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f30)
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            titleLabel.textColor = UIColor.white
        } else {
            titleLabel.textColor = UIColor.black
        }
    }
    
}
