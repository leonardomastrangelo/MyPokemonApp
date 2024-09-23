import Foundation

struct Constants {
    
    static let appTitle = "PokemonApp"
    
    struct Network {
        static let baseUrl = "https://pokeapi.co/api/v2/pokemon"
        static let limit = 20
    }
    
    struct TBView {
        static let cellIdentifier = "ReusableCell"
        static let cellNibName = "PokemonCell"
        static let homeToDetail = "HomeToDetail"
    }
    
}

// controllare passare parametri per ricevere dati in più, se non ne mostro limite 3 e prima di motrare la lista, ne chiamo il dettaglio. Chiamo api pokemon -> loader -> ricevo reponse 3 elemnt -> per ogni elemento api del dettaglio -> tutti e 3 completati, li nostro con qualche dettaglio aggiuntivo con dispatchGroup (sapere quando tutte e 3 sono completati)

// paginazione
