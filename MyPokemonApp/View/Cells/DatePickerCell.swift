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
        
        KeychainManager.loadData(service: Constants.Keychain.serviceName, account: accountKey) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let value):
                    if let savedDate = DateHelper.stringToDate(value) {
                        self.datePicker.date = savedDate
                    }
                case .failure(let error):
                    print("Error loading data: \(error.localizedDescription)")
                }
                self.updateLocale()
                self.applyTitleAndTheme()
            }
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
            KeychainManager.saveData(service: Constants.Keychain.serviceName, account: key, data: dateString) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success():
                        print("Date saved successfully.")
                    case .failure(let error):
                        print("Error saving date: \(error.localizedDescription)")
                    }
                }
            }
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
