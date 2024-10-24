import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        
        updateTabBarTitles()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTabBarTitles), name: Notification.Name("LanguageChanged"), object: nil)
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateTabBarTitles()
    }
    
    @objc func updateTabBarTitles() {
        guard let items = tabBar.items else { return }
        
        items[0].title = "Home".translated()
        items[1].title = "You".translated()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("LanguageChanged"), object: nil)
    }
}
