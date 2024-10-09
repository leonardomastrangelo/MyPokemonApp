import UIKit

class SectionTwoCell: UITableViewCell {
    
    @IBOutlet weak var customTitleLabel: UILabel!
    @IBOutlet weak var customDetailLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTitleLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f22)
        customDetailLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f19)
        applyTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(titleText: String, detailText: String) {
        customTitleLabel.text = titleText
        customDetailLabel.text = detailText
    }
    
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        if isDarkMode {
            customTitleLabel.textColor = UIColor.white
            customDetailLabel.textColor = UIColor.lightGray
            backgroundColor = UIColor.black.withAlphaComponent(CGFloat(0.7))
        } else {
            customTitleLabel.textColor = UIColor.black
            customDetailLabel.textColor = UIColor.darkGray
            backgroundColor = UIColor.systemYellow.withAlphaComponent(CGFloat(0.7))
        }
    }
}
