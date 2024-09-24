import Foundation

struct Constants {
    
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

// sistema di traduzione localizzate italiano inglese
// default lingua del sistema
// cambiare lingua
// senza chiudere app cambiare lingua

// integrare networkLayer per fare chiamate rest -> important : DONE

