import Foundation
import Security

enum KeychainError: Error {
    case itemNotFound
    case duplicateItem
    case unexpectedData
    case unhandledError(status: OSStatus)
    
    var localizedDescription: String {
        switch self {
        case .itemNotFound:
            return "Item not found."
        case .duplicateItem:
            return "Duplicate item."
        case .unexpectedData:
            return "Unexpected data."
        case .unhandledError(let status):
            return "Unhandled error: \(status)"
        }
    }
}


class KeychainManager {
    
    class func saveData(service: String, account: String, data: String, completion: @escaping (Swift.Result<Void, KeychainError>) -> Void) {
        let dataFromString = data.data(using: .utf8)!
        let query: [String: Any] = [
            /* IMPORTANT */
            kSecClass as String: kSecClassGenericPassword,
            
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: dataFromString
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        switch status {
        case errSecSuccess:
            print("Successfully saved data for : \(account)")
            completion(.success(()))
        case errSecDuplicateItem:
            completion(.failure(.duplicateItem))
        default:
            completion(.failure(.unhandledError(status: status)))
        }
    }
    
    class func loadData(service: String, account: String, completion: @escaping (Swift.Result<String, KeychainError>) -> Void) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        switch status {
        case errSecSuccess:
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let value = String(data: data, encoding: .utf8) {
                completion(.success(value))
            } else {
                completion(.failure(.unexpectedData))
            }
        case errSecItemNotFound:
            completion(.failure(.itemNotFound))
        default:
            completion(.failure(.unhandledError(status: status)))
        }
    }
}



