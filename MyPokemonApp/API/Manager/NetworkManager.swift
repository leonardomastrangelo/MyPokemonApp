import Foundation

enum LogLevel: String {
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

func log(_ message: String, level: LogLevel = .info) {
    let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .medium)
    print("[\(timestamp)] [\(level.rawValue)] \(message)")
}

enum NetworkError: Error {
    case invalidURL
    case requestFailed(Error)
    case invalidResponse
    case decodingFailed(Error)
}

struct NetworkManager {
    
    static let shared = NetworkManager()
    private let maxRetryAttempts = Constants.Network.maxRetryAttempts

    private var session: URLSession {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = Constants.Network.timeOutInterval
        sessionConfig.httpCookieStorage = HTTPCookieStorage.shared
        sessionConfig.httpShouldSetCookies = true
        return URLSession(configuration: sessionConfig)
    }

    private init() {}

    func performRequestWithRetry<T: Decodable>(endpoint: Endpoint, retryCount: Int = 0, completion: @escaping (Swift.Result<T, NetworkError>) -> Void) {
        
        guard let url = endpoint.url else {
            log("Invalid URL: \(String(describing: endpoint.url))", level: .error)
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue

        log("Sending request to \(url)", level: .info)

        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                if retryCount < self.maxRetryAttempts {
                    log("Error: \(error.localizedDescription). Retrying request... Attempt \(retryCount + 1)", level: .warning)
                    self.performRequestWithRetry(endpoint: endpoint, retryCount: retryCount + 1, completion: completion)
                } else {
                    log("Request failed after \(retryCount) attempts: \(error.localizedDescription)", level: .error)
                    completion(.failure(.requestFailed(error)))
                }
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                log("Invalid response: \(String(describing: response))", level: .error)
                completion(.failure(.invalidResponse))
                return
            }

            guard 200..<300 ~= httpResponse.statusCode else {
                log("Received HTTP \(httpResponse.statusCode) response", level: .warning)
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                log("No data received", level: .error)
                completion(.failure(.invalidResponse))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                log("Successfully decoded response for \(url)", level: .info)
                completion(.success(decodedObject))
            } catch {
                log("Decoding failed: \(error.localizedDescription)", level: .error)
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
}

