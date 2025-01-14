import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var settingTableView: UITableView!
    @IBOutlet weak var settingsBackgroundImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refreshLanguage()
        applyTheme(isDarkMode: UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey))
    }
    
    // MARK: - Setup Methods
    private func setupTableView() {
        settingTableView.dataSource = self
        settingTableView.delegate = self
    }
}

// MARK: - Language and Theme Methods
extension SettingsViewController {
    func refreshLanguage() {
        titleLabel.text = "Settings".translated().uppercased()
        titleLabel.font = UIFont.customFont(ofSize: Constants.FontSizes.f40)
    }
    
    @objc func darkModeSwitchChanged(_ sender: UISwitch) {
        let isDarkMode = sender.isOn
        UserDefaults.standard.set(isDarkMode, forKey: Constants.UserDefaults.darkModeKey)
        applyTheme(isDarkMode: isDarkMode)
    }
    
    private func applyTheme(isDarkMode: Bool) {
        view.backgroundColor = isDarkMode ? .black : .white
        titleLabel.textColor = isDarkMode ? .white : .black
        settingsBackgroundImage.image = isDarkMode ? UIImage(named: Constants.Images.darkSettingsBackground) : UIImage(named: Constants.Images.lightSettingsBackground)
        settingTableView.separatorColor = isDarkMode ? .white : .black
        settingTableView.reloadData()
    }
    
    func updateCellAppearance(cell: UITableViewCell, isDarkMode: Bool) {
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = isDarkMode ? .white : .black
    }
}

