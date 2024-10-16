import UIKit

class LanguageSelectionViewController: UIViewController {
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    let supportedLanguages = [Constants.SupportedLanguages.english, Constants.SupportedLanguages.italian]
    var selectedLanguage: String = Constants.LocalizedStrings.localizedDefaultLanguage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
        refreshUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        applyTheme(isDarkMode: UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey))
    }
}

//MARK: - UI Setup and Language handling
extension LanguageSelectionViewController {
    private func setupPickerView() {
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
        if let currentLanguage = UserDefaults.standard.string(forKey: Constants.LocalizedStrings.localizedUserDefaultKey),
           let selectedIndex = supportedLanguages.firstIndex(of: currentLanguage) {
            languagePickerView.selectRow(selectedIndex, inComponent: 0, animated: false)
        }
    }
    
    private func refreshUI() {
        title = "Select_language".translated()
        languagePickerView.reloadAllComponents()
    }
    
    private func changeLanguage(to languageCode: String) {
        UserDefaults.standard.set(languageCode, forKey: Constants.LocalizedStrings.localizedUserDefaultKey)
        UserDefaults.standard.synchronize()
        
        refreshUI()
    }
    
    private func applyTheme(isDarkMode: Bool) {
        view.backgroundColor = isDarkMode ? .black : .white
        languagePickerView.tintColor = isDarkMode ? .white : .black
        languagePickerView.reloadAllComponents()
    }
}

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
