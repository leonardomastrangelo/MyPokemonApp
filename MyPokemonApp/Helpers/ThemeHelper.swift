import UIKit

import UIKit

extension UIView {
    func applyThemeHelper() {
        let isDarkModeEnabled = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey)
        self.backgroundColor = isDarkModeEnabled ? .black : .white
        
        if let label = self as? UILabel {
            label.textColor = isDarkModeEnabled ? .white : .black
        } else if let textField = self as? UITextField {
            textField.textColor = isDarkModeEnabled ? .white : .black
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: isDarkModeEnabled ? UIColor.lightGray : UIColor.darkGray]
            )
        } else if let button = self as? UIButton {
            button.tintColor = isDarkModeEnabled ? .white : .black
        }
    }
    
    func applyThemeToAllSubviews() {
        applyThemeHelper()
        for subview in subviews {
            subview.applyThemeHelper()
        }
    }
}
