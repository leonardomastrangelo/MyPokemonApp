import UIKit

class LoginViewController: UIViewController {
    
    let loginInputView: InputView = {
        let view = InputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Login".translated()
        view.actionButton.setTitle("Login".translated(), for: .normal)
        view.navigateButton.setTitle("No_Account".translated(), for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(loginInputView)
        
        setupInputViewConstraints(loginInputView)
        addButtonTargets()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        applyTheme()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addButtonTargets() {
        loginInputView.actionButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        loginInputView.navigateButton.addTarget(self, action: #selector(handleNavigation), for: .touchUpInside)
    }
    
    @objc private func handleLogin() {
        navigateToTabBarController()
    }
    
    @objc private func handleNavigation() {
        let registerViewController = RegisterViewController()
        navigationController?.pushViewController(registerViewController, animated: true)
    }
    
    func applyTheme() {
        loginInputView.applyThemeToAllSubviews()
        view.backgroundColor = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey) ? .black : .white
    }
}
