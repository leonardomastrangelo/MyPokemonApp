import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectionLabel: UILabel!
    
    @IBOutlet weak var englishLabel: UIButton!
    @IBOutlet weak var italianLabel: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        refreshLanguage()
    }
    
    func refreshLanguage() {
        titleLabel.text = "title".translated()
        selectionLabel.text = "select language".translated()
        englishLabel.setTitle("English".translated(), for: .normal)
        italianLabel.setTitle("Italian".translated(), for: .normal)
    }
    
    @IBAction func englishPressed(_ sender: UIButton) {
        changeLang(to: "en")
    }
    
    @IBAction func italianPressed(_ sender: UIButton) {
        changeLang(to: "it")
    }
    
    private func changeLang(to language: String) {
        UserDefaults.standard.set(language, forKey: Constants.LocalizedStrings.localizedUserDefaultKey)
        Constants.LocalizedStrings.localizedDefaultLanguage = language
        refreshLanguage()
        
        if let tabBarController = self.tabBarController as? CustomTabBarController {
            tabBarController.updateTabBarTitles()
        }
    }
    
}

