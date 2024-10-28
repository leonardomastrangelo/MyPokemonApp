import UIKit

class RegisterViewController: UIViewController {
    
    let registerInputView: InputView = {
        let view = InputView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.titleLabel.text = "Register".translated()
        view.actionButton.setTitle("Register".translated(), for: .normal)
        view.navigateButton.setTitle("Already_Have_An_Account?".translated(), for: .normal)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(registerInputView)
        
        setupInputViewConstraints(registerInputView)
        addButtonTargets()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        applyTheme()
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addButtonTargets() {
        registerInputView.actionButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        registerInputView.navigateButton.addTarget(self, action: #selector(handleNavigation), for: .touchUpInside)
    }
    
    @objc private func handleRegister() {
        navigateToTabBarController()
    }
    
    @objc private func handleNavigation() {
        navigationController?.popViewController(animated: true)
    }
    
    func applyTheme() {
        registerInputView.applyThemeToAllSubviews()
        view.backgroundColor = UserDefaults.standard.bool(forKey: Constants.UserDefaults.darkModeKey) ? .black : .white
    }
}
