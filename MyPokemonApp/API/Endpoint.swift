import Foundation

protocol Endpoint {
    var path: String { get }
    var queryItems: [URLQueryItem]? { get }
    var method: HTTPMethod { get }
    func asURLRequest() throws -> URLRequest
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.Network.scheme
        components.host = Constants.Network.host
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
    
    func asURLRequest() throws -> URLRequest {
        guard let url = url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.timeoutInterval = Constants.Network.timeOutInterval
        return request
    }
}
