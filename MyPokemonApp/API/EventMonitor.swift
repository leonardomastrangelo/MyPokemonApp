//
//  EventMonitor.swift
import Foundation

protocol NetworkEventMonitor {
    func requestDidStart(_ request: URLRequest)
    func requestDidFinish(_ request: URLRequest, response: URLResponse?, data: Data?)
}

class ConsoleEventMonitor: NetworkEventMonitor {
    func requestDidStart(_ request: URLRequest) {
        print("Request started: \(request.url?.absoluteString ?? "No URL")")
    }
    
    func requestDidFinish(_ request: URLRequest, response: URLResponse?, data: Data?) {
        print("Request finished: \(request.url?.absoluteString ?? "No URL")")
    }
}
