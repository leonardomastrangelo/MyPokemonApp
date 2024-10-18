//
//  CustomTabBarController.swift
import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        updateTabBarTitles()
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        updateTabBarTitles()
    }
    
    func updateTabBarTitles() {
        guard let items = tabBar.items else { return }
        
        items[0].title = "Home".translated()
        items[1].title = "User"
    }
}

