import UIKit

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

struct NetworkManager {
    static let shared = NetworkManager()
    private let maxRetryAttempts = 3
    private let interceptor: RequestInterceptor?
    private let eventMonitor: NetworkEventMonitor?
    
    private var session: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 30
        return URLSession(configuration: sessionConfig)
    }
    
    private init(interceptor: RequestInterceptor? = LoggingInterceptor(), eventMonitor: NetworkEventMonitor? = ConsoleEventMonitor()) {
        self.interceptor = interceptor
        self.eventMonitor = eventMonitor
    }
    
    func performRequestWithRetry<T: Decodable>(endpoint: Endpoint, retryCount: Int = 0, completion: @escaping (Swift.Result<T, NetworkError>) -> Void) {
        do {
            var request = try endpoint.asURLRequest()
            
            request = interceptor?.intercept(request: request) ?? request
            
            eventMonitor?.requestDidStart(request)
            
            let task = session.dataTask(with: request) { data, response, error in
                
                self.eventMonitor?.requestDidFinish(request, response: response, data: data)
                
                if let error = error {
                    if retryCount < self.maxRetryAttempts {
                        self.performRequestWithRetry(endpoint: endpoint, retryCount: retryCount + 1, completion: completion)
                    } else {
                        completion(.failure(.requestFailed(error)))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                guard var data = data else {
                    completion(.failure(.invalidResponse))
                    return
                }
                
                data = self.interceptor?.intercept(response: httpResponse, data: data) ?? data
                
                do {
                    let decodedObject = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(.decodingFailed(error)))
                }
            }
            task.resume()
        } catch {
            completion(.failure(.invalidURL))
        }
    }
    
    func fetchImage(from url: URL, completion: @escaping (Swift.Result<UIImage, NetworkError>) -> Void) {
        var request = URLRequest(url: url)
        request = interceptor?.intercept(request: request) ?? request
        
        eventMonitor?.requestDidStart(request)
        
        let task = session.dataTask(with: request) { data, response, error in
            self.eventMonitor?.requestDidFinish(request, response: response, data: data)
            
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(image))
        }
        task.resume()
    }
}
