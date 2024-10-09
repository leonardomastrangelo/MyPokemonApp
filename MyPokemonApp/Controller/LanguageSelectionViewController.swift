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
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch supportedLanguages[row] {
        case Constants.SupportedLanguages.english:
            return "English".translated()
        case Constants.SupportedLanguages.italian:
            return "Italian".translated()
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedLanguageCode = supportedLanguages[row]
        changeLanguage(to: selectedLanguageCode)
    }
}
