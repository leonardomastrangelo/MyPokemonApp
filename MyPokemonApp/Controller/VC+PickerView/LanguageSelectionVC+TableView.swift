import UIKit

// MARK: - UIPickerView DataSource
extension LanguageSelectionViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return supportedLanguages.count
    }
}

// MARK: - UIPickerView Delegate
extension LanguageSelectionViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let title: String
        switch supportedLanguages[row] {
        case Constants.SupportedLanguages.english:
            title = "English".translated()
        case Constants.SupportedLanguages.italian:
            title = "Italian".translated()
        default:
            title = ""
        }
        
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        let textColor = isDarkMode ? UIColor.white : UIColor.black
        
        return NSAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: textColor])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLanguageCode = supportedLanguages[row]
        changeLanguage(to: selectedLanguageCode)
    }
}
