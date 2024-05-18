
import Foundation
import SwiftKeychainWrapper

final class KeychainManager {
     static let keychain = KeychainManager()
     private var userEmailKey: String = "easy-chores-user-email"
     private var userPasswordKey: String = "easy-chores-user-assword"
     private var accessTokenKey: String = "easy-chores-user-access-token"
    
     var userEmail: String? {
         get {
             KeychainWrapper.standard.string(forKey: userEmailKey)
         }
         set {
             if let newEmail = newValue {
                 KeychainWrapper.standard.set(newEmail, forKey: userEmailKey)
             } else {
                 KeychainWrapper.standard.removeObject(forKey: userEmailKey)
             }
         }
     }
    
     var userPassword: String? {
         get {
             KeychainWrapper.standard.string(forKey: userPasswordKey)
         }
         set {
             if let newPassword = newValue {
                 KeychainWrapper.standard.set(newPassword, forKey: userPasswordKey)
             } else {
                 KeychainWrapper.standard.removeObject(forKey: userPasswordKey)
             }
         }
     }
    var accessToken: String? {
        get {
            KeychainWrapper.standard.string(forKey: accessTokenKey)
        }
        set {
            if let newToken = newValue {
                KeychainWrapper.standard.set(newToken, forKey: accessTokenKey)
            } else {
                KeychainWrapper.standard.removeObject(forKey: accessTokenKey)
            }
        }
    }

    
    func removeAllKeys() {
        KeychainWrapper.standard.removeAllKeys()
    }
}
