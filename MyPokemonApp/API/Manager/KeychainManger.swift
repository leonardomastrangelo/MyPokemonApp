import Foundation
import Security

class KeychainManager {
    
    class func saveData(service: String, account: String, data: String) {
        let dataFromString = data.data(using: .utf8)!
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: dataFromString
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        if status == noErr {
            print("Successfully saved data for : \(account)")
        } else {
            print("Error during data saving: \(status)")
        }
    }
    
    class func loadData(service: String, account: String) -> String? {
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
        
        if status == noErr {
            if let existingItem = item as? [String: Any],
               let data = existingItem[kSecValueData as String] as? Data,
               let value = String(data: data, encoding: .utf8) {
                return value
            }
        }
        
        print("Error during data loading: \(status)")
        return nil
    }
    
}

