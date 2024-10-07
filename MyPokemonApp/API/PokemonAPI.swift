import Foundation

enum PokemonAPI: Endpoint {
    case getPokemonList(offset: Int, limit: Int)
    case getPokemonByName(name: String)
    
    var path: String {
        switch self {
        case .getPokemonList:
            return "/api/v2/pokemon"
        case .getPokemonByName(let name):
            return "/api/v2/pokemon/\(name)"
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
        switch self {
        case .getPokemonList, .getPokemonByName:
            return .get
        }
    }
    
}
