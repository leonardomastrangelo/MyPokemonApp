import UIKit

extension UIViewController  {
    func updateBackButtonTitle() {
        let backButtonTitle = "Back".translated()
        let backItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
    
    func addSettingsButton() {
        let gearImage = UIImage(systemName: "gear")
        let settingsButton = UIBarButtonItem(image: gearImage, style: .plain, target: self, action: #selector(openSettings))
        
        self.navigationItem.rightBarButtonItem = settingsButton
    }
    
    @objc private func openSettings() {
        if let settingsVC = storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") {
            navigationController?.pushViewController(settingsVC, animated: true)
        }
    }
}
