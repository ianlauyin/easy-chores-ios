import Foundation



class APIManager {
    static let request = APIManager()
    
    func register(email:String,password:String,username:String) async throws ->[String:Any]{
            guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
                throw CustomDataError.envError
            }
            guard let urlInstance = URL(string: BACKEND_URL + "/users/register") else {
                throw APIError.invalidURL
            }
            var request = URLRequest(url:urlInstance)
            request.httpMethod = "POST"
            let registerData = ["email":email,"password":password,"username":username]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: registerData) else {
                throw CustomDataError.invalidDataForJSON
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                throw APIError.requestFailed
            }
            
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard var userData = jsonObject as? [String: Any] else {
                throw CustomDataError.invalidJSONForData
            }
            
            let checkKeys = ["user_id","username","access_token"]
            if checkKeys.allSatisfy({ key in
                userData[key] != nil
            }) {
                KeychainManager.keychain.accessToken = userData["access_token"] as? String
            } else {
                throw APIError.invalidResponseData
            }
            userData.removeValue(forKey: "access_token")
            return userData
    }
    
    func login(email:String,password:String) async throws->[String:Any]{
        do{
            guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
                throw CustomDataError.envError
            }
            guard let urlInstance = URL(string: BACKEND_URL + "/users/login") else {
                throw APIError.invalidURL
            }
            var request = URLRequest(url:urlInstance)
            request.httpMethod = "POST"
            let loginData = ["email":email,"password":password]
            guard let jsonData = try? JSONSerialization.data(withJSONObject: loginData) else {
                throw CustomDataError.invalidDataForJSON
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse,
                  httpResponse.statusCode != 401 else{
                throw APIError.invalidLoginData
            }
            if !(200...299).contains(httpResponse.statusCode){
                throw APIError.requestFailed
            }
            
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
            
            guard var userData = jsonObject as? [String: Any] else {
                throw CustomDataError.invalidJSONForData
            }
            
            let checkKeys = ["user_id","username","access_token"]
            if checkKeys.allSatisfy({ key in
                userData[key] != nil
            }) {
                KeychainManager.keychain.accessToken = userData["access_token"] as? String
            } else {
                throw APIError.invalidResponseData
            }
            userData.removeValue(forKey: "access_token")
            return userData
        }catch{
            //Remove All user data and access token if the cannot login
            //Prevent looping
            KeychainManager.keychain.removeAllKeys()
            throw error
        }
    }
    
    func refreshToken(retry: () async throws -> Data) async throws-> Data {
        if let email = KeychainManager.keychain.userEmail,
           let password = KeychainManager.keychain.userPassword{
            _ =  try await login(email: email, password: password)
            return try await retry()
        }else{
            throw APIError.invalidLoginData
        }
    }

    func get(url: String) async throws -> Data {
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw CustomDataError.envError
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: urlInstance)
        request.httpMethod = "GET"
        
        request.setValue(KeychainManager.keychain.accessToken, forHTTPHeaderField: "Authorization")

        let (responseData, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode != 401 else{
            return try await refreshToken{
                return try await get(url:url)
            }
        }
        
        if !(200...299).contains(httpResponse.statusCode){
            throw APIError.requestFailed
        }
        
        return responseData
    }

    func post(url: String, data: Dictionary<String, Any>) async throws -> Data {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            throw CustomDataError.invalidDataForJSON
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw CustomDataError.envError
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.httpMethod = "POST"
        request.setValue(KeychainManager.keychain.accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        

        let (responseData, response) = try await URLSession.shared.data(for: request)
        
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode != 401 else{
            return try await refreshToken{
                return try await post(url:url,data:data)
            }
        }
        
        if !(200...299).contains(httpResponse.statusCode){
            throw APIError.requestFailed
        }

        return responseData
    }

    func put(url: String, data: Dictionary<String, Any>) async throws -> Data{
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            throw CustomDataError.invalidDataForJSON
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw CustomDataError.envError
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.httpMethod = "PUT"
        request.setValue(KeychainManager.keychain.accessToken, forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (responseData, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode != 401 else{
            return try await refreshToken{
                return try await put(url:url,data:data)
            }
        }
        
        if !(200...299).contains(httpResponse.statusCode){
            throw APIError.requestFailed
        }

        return responseData
    }

    func delete(url: String) async throws -> Data {
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw CustomDataError.envError
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.setValue(KeychainManager.keychain.accessToken, forHTTPHeaderField: "Authorization")
        request.httpMethod = "DELETE"

        let (responseData, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode != 401 else{
            return try await refreshToken{
                return try await delete(url:url)
            }
        }
        
        if !(200...299).contains(httpResponse.statusCode){
            throw APIError.requestFailed
        }
        

        return responseData
    }
}
