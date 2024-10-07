//
//  String+Extension.swift
import Foundation

extension String {
    func translated() -> String {
        let languageCode = UserDefaults.standard.string(forKey: Constants.LocalizedStrings.localizedUserDefaultKey) ?? "en"
        if let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            return NSLocalizedString(self, bundle: bundle, comment: "")
        }
        return NSLocalizedString(self, comment: "")
    }
}
