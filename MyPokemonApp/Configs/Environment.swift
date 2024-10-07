//
//  Environment.swift
import Foundation

public enum EnvironmentError: Error {
    case missingKey(String)
    case invalidValue(String)
    
    var localizedDescription: String {
        switch self {
        case .missingKey(let key):
            return "\(key) is missing in Info.plist"
        case .invalidValue(let key):
            return "\(key) has an invalid value in Info.plist"
        }
    }
}

public enum Environment {
    
    private enum Keys: String {
        case apiBaseUrl = "API_BASE_URL"
        case apiKey = "API_KEY"
        case isProduction = "IS_PRODUCTION"
        case envName = "ENV_NAME"
    }
    
    private static let infoDictionary: [String: Any]? = Bundle.main.infoDictionary
    
    static let apiBaseUrl: URL = {
        if let urlString = infoDictionary?[Keys.apiBaseUrl.rawValue] as? String,
           let url = URL(string: urlString) {
            return url
        } else if infoDictionary?[Keys.apiBaseUrl.rawValue] == nil {
            fatalError(EnvironmentError.missingKey(Keys.apiBaseUrl.rawValue).localizedDescription)
        } else {
            fatalError(EnvironmentError.invalidValue(Keys.apiBaseUrl.rawValue).localizedDescription)
        }
    }()
    
    static let apiKey: String = {
        if let key = infoDictionary?[Keys.apiKey.rawValue] as? String {
            return key
        } else {
            fatalError(EnvironmentError.missingKey(Keys.apiKey.rawValue).localizedDescription)
        }
    }()
    
    static let isProduction: String = {
        if let isProduction = infoDictionary?[Keys.isProduction.rawValue] as? String {
            return isProduction
        } else {
            fatalError(EnvironmentError.missingKey(Keys.isProduction.rawValue).localizedDescription)
        }
    }()
    
    static let envName: String = {
        if let name = infoDictionary?[Keys.envName.rawValue] as? String {
            return name
        } else {
            fatalError(EnvironmentError.missingKey(Keys.envName.rawValue).localizedDescription)
        }
    }()
}
