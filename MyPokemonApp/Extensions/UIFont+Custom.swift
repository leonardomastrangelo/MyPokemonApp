//
//  UIFont+Custom.swift
import UIKit

extension UIFont {
    static func customFont(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "PixelifySans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}

