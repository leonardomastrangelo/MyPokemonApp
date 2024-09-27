//
//  NavigatorHelper.swift
//  MyPokemonApp

import UIKit

extension UIViewController  {
    func updateBackButtonTitle() {
        let backButtonTitle = "Back".translated()
        let backItem = UIBarButtonItem(title: backButtonTitle, style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backItem
    }
}
