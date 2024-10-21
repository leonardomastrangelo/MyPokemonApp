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
    
    func configure(placeholder: String, accountKey: String?) {
        self.accountKey = accountKey
        
        customTextField.returnKeyType = .done
        
        customTextField.placeholder = placeholder
        
        customTextField.font = UIFont.customFont(ofSize: Constants.FontSizes.f19)
        
        if let key = accountKey {
            KeychainManager.loadData(service: Constants.Keychain.serviceName, account: key) { result in
                switch result {
                case .success(let value):
                    DispatchQueue.main.async {
                        self.customTextField.text = value
                    }
                case .failure(let error):
                    print("Error loading data: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.customTextField.text = ""
                    }
                }
            }
        } else {
            print("Account key is nil.")
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
            KeychainManager.saveData(service: Constants.Keychain.serviceName, account: key, data: text) { result in
                switch result {
                case .success():
                    print("Successfully saved data for : \(key)")
                case .failure(let error):
                    print("Error saving data: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
