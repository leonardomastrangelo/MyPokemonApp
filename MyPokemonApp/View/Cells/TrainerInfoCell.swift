import UIKit

class TrainerInfoCell: UITableViewCell {
    
    @IBOutlet weak var customTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(titleText: String) {
        customTitleLabel.text = titleText
        applyTheme()
    }
    
    private func applyTheme() {
        customTitleLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f19)
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            customTitleLabel.textColor = UIColor.white
            
        } else {
            customTitleLabel.textColor = UIColor.black
        }
    }
    
}
