import UIKit

extension UIViewController {
    func setupInputViewConstraints(_ inputView: InputView) {
        inputView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            inputView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            inputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            inputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            inputView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -20)
        ])
    }
}
