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
        static let scheme = "https"
        static let host = "pokeapi.co"
    }
    
    struct TBView {
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "PokemonCell"
        static let homeToDetail = "HomeToDetail"
    }
    
}


