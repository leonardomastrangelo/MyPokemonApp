import UIKit

class InputView: UIView, UITextFieldDelegate {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.customFont(ofSize: Constants.FontSizes.f22)
        label.textAlignment = .center
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Email"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Password"
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        configureActionButton(button, title: "Login")
        return button
    }()
    
    lazy var navigateButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        configureNavigateButton(button, title: "Go to")
        return button
    }()
    
    private func configureActionButton(_ button: UIButton, title: String) {
        var configuration = UIButton.Configuration.filled()
        configuration.title = title
        configuration.baseBackgroundColor = .systemBlue
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .medium
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        
        button.configuration = configuration
    }
    
    private func configureNavigateButton(_ button: UIButton, title: String) {
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        configuration.baseForegroundColor = .systemBlue
        configuration.cornerStyle = .medium
        
        button.configuration = configuration
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        applyThemeToAllSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(titleLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(actionButton)
        addSubview(navigateButton)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20),
            passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
            
            actionButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            actionButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            navigateButton.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 10),
            navigateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            navigateButton.heightAnchor.constraint(equalToConstant: 44),
            navigateButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

