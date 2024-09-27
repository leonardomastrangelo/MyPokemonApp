import Foundation

struct Constants {
    
    struct LocalizedStrings {
        static let localizedUserDefaultKey = "LocalizedUserDefaultKey"
        static var localizedDefaultLanguage = "en"
    }
    
    static let appTitle = "PokemonApp"
    
    struct Network {
        static let limit = 20
        static let maxRetryAttempts = 3
        static let timeOutInterval = 30.0
    }
    
    struct TBView {
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "PokemonCell"
        static let homeToDetail = "HomeToDetail"
    }
    
}

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

