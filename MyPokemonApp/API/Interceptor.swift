//
//  Interceptor.swift
import Foundation

protocol RequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest
    func intercept(response: URLResponse, data: Data?) -> Data?
}

class LoggingInterceptor: RequestInterceptor {
    func intercept(request: URLRequest) -> URLRequest {
        print("Sending request to: \(request.url?.absoluteString ?? "No URL")")
        return request
    }
    
    func intercept(response: URLResponse, data: Data?) -> Data? {
        if let httpResponse = response as? HTTPURLResponse {
            print("Received response: \(httpResponse.statusCode) for \(httpResponse.url?.absoluteString ?? "No URL")")
        }
        return data
    }
}

