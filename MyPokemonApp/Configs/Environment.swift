//
//  Environment.swift
import Foundation

public enum Environment {
    
    private enum Keys: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiKey = "API_KEY"
        case isProduction = "IS_PRODUCTION"
        case envName = "ENV_NAME"
    }
    
    private static let infoDictionary: [String: Any] = Bundle.main.infoDictionary!
    
    static let apiBaseUrl: URL = .init(string: infoDictionary[Keys.apiBaseUrl.rawValue] as! String)!
    static let apiKey: String = infoDictionary[Keys.apiKey.rawValue] as! String
    
    static let isProduction = infoDictionary[Keys.isProduction.rawValue] as! String
    static let envName = infoDictionary[Keys.envName.rawValue] as! String

    
}
