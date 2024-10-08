import UIKit

class LanguageSelectionViewController: UIViewController {
    
    @IBOutlet weak var languagePickerView: UIPickerView!
    
    let supportedLanguages = [Constants.SupportedLanguages.english, Constants.SupportedLanguages.italian]
    var selectedLanguage: String = Constants.LocalizedStrings.localizedDefaultLanguage
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        languagePickerView.dataSource = self
        languagePickerView.delegate = self
        
    }
}

// MARK: - UIPickerView Building & Actions
extension LanguageSelectionViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return supportedLanguages.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch supportedLanguages[row] {
        case Constants.SupportedLanguages.english:
            return "English"
        case Constants.SupportedLanguages.italian:
            return "Italian"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
}

