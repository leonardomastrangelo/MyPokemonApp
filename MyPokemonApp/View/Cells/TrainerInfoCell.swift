import UIKit

class TrainerInfoCell: UITableViewCell {
    
    @IBOutlet weak var customTextField: UITextField!
    var accountKey: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customTextField.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(placeholder: String, accountKey: String) {
        self.accountKey = accountKey
        
        customTextField.returnKeyType = .done
        
        customTextField.placeholder = placeholder
        
        customTextField.font = UIFont.customFont(ofSize: Constants.FontSizes.f19)
        
        if let value = KeychainManager.loadData(service: Constants.Keychain.serviceName, account: accountKey) {
            customTextField.text = value
        } else {
            customTextField.text = ""
        }
        
        applyTheme()
    }
    
    private func applyTheme() {
        let isDarkMode = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        
        customTextField.textColor = isDarkMode ? UIColor.white : UIColor.black
    }
}

//MARK: - UITextFieldDelegate
extension TrainerInfoCell: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, let key = accountKey {
            print("Text field editing ended with text: \(text)")
            KeychainManager.saveData(service: Constants.Keychain.serviceName, account: key, data: text)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text, let key = accountKey {
            print("Text field return pressed with text: \(text)")
            KeychainManager.saveData(service: Constants.Keychain.serviceName, account: key, data: text)
        }
        textField.resignFirstResponder()
        return true
    }
}
