import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
}

extension Endpoint {
    var baseURL: String {
        return "https://pokeapi.co/api/v2"
    }
    
    var url: URL? {
        var components = URLComponents(string: baseURL + path)
        components?.queryItems = queryItems
        return components?.url
    }
}
