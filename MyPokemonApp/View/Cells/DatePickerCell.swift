import UIKit

class DatePickerCell: UITableViewCell {
    
    @IBOutlet weak var labelText: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    var accountKey: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDatePicker()
        applyTitleAndTheme()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(accountKey: String) {
        self.accountKey = accountKey
        
        if let value = KeychainManager.loadData(service: Constants.Keychain.serviceName, account: accountKey),
           let savedDate = DateHelper.stringToDate(value) {
            datePicker.date = savedDate
        }
        
        updateLocale()
        applyTitleAndTheme()
    }
    
    func updateLocale() {
        if let selectedLanguage = UserDefaults.standard.string(forKey: Constants.LocalizedStrings.localizedUserDefaultKey) {
            datePicker.locale = Locale(identifier: selectedLanguage)
        } else {
            datePicker.locale = Locale.current
        }
    }
    
    private func setupDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        updateLocale()
        
        datePicker.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
    }
    
    @objc private func dateChanged(_ sender: UIDatePicker) {
        if let key = accountKey {
            let dateString = DateHelper.dateToString(sender.date)
            print("Saving date: \(dateString)")
            KeychainManager.saveData(service: Constants.Keychain.serviceName, account: key, data: dateString)
        }
    }
    
    private func applyTitleAndTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        labelText.text = "Birthday".translated()
        labelText.textColor = isDarkMode ? .white.withAlphaComponent(0.6) : .black.withAlphaComponent(0.6)
        labelText.font = UIFont.customFont(ofSize: Constants.FontSizes.f15)
        
        datePicker.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
    }
}
