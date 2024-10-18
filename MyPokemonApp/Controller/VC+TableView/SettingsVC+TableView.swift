import UIKit

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
