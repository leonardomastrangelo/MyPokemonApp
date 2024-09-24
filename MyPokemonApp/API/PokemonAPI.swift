import Foundation

enum PokemonAPI: Endpoint {
    case getPokemonList(offset: Int, limit: Int)
    case getPokemonByName(name: String)
    
    var path: String {
        switch self {
        case .getPokemonList:
            return "/pokemon"
        case .getPokemonByName(let name):
            return "/pokemon/\(name)"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .getPokemonList(let offset, let limit):
            return [
                URLQueryItem(name: "offset", value: "\(offset)"),
                URLQueryItem(name: "limit", value: "\(limit)")
            ]
        case .getPokemonByName:
            return nil
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
}
