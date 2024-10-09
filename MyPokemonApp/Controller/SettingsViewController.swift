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
    
    private func updateCellAppearance(cell: UITableViewCell, isDarkMode: Bool) {
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = isDarkMode ? .white : .black
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.languageCellIdentifier, for: indexPath)
            cell.textLabel?.text = "Supported_Languages".translated()
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: Constants.TBView.darkModeCellIdentifier, for: indexPath)
            cell.textLabel?.text = "Dark_Mode".translated()
            
            let switchView = UISwitch(frame: .zero)
            switchView.isOn = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
            switchView.addTarget(self, action: #selector(darkModeSwitchChanged(_:)), for: .valueChanged)
            cell.accessoryView = switchView
        }
        
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        updateCellAppearance(cell: cell, isDarkMode: isDarkMode)
        
        cell.textLabel?.font = UIFont.customFont(ofSize: 18)
        return cell
    }
}

//MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "settingsToLanguages", sender: self)
        }
    }
}
