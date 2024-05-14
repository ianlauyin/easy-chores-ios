

import Foundation
import DotEnv

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case invalidReponseData
}

class APIManager {
    static let apiManager = APIManager()
    private let env = DotEnv(withFile: ".env")
    private init() {}
    
    
    func get(url: String, completion: @escaping (Result<Dictionary<String,Any>,APIError>) -> Void){
        guard let urlInstance = URL(string:env.get("BACKEND_URL")! + url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlInstance) { (data, response, error) in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(.requestFailed))
                        return
                        }
            
            //Ensure there is a data coming from the reponse
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let dictData = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                completion(.failure(.invalidData))
                return
            }
            completion(.success(dictData))
        }
        
        task.resume()
    }
    
    func post(url: String, data: Dictionary<String, Any>, completion: @escaping (Result<Dictionary<String, Any>?, APIError>) -> Void) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            completion(.failure(.invalidData))
            return
        }
        guard let urlInstance = URL(string:env.get("BACKEND_URL")! + url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: urlInstance)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(.requestFailed))
                        return
                        }
            
            guard let data = data else {
                completion(.success(nil))
                return
            }
            
            guard let dictData = try? JSONSerialization.jsonObject(with: data , options: []) as? Dictionary<String, Any>else{
                completion(.failure(.invalidReponseData))
                return
            }
            completion(.success(dictData))
        }
        
        task.resume()
    }
    
    func put(url: String, data: Dictionary<String, Any>, completion: @escaping (Result<Dictionary<String, Any>?, APIError>) -> Void) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            completion(.failure(.invalidData))
            return
        }
        guard let urlInstance = URL(string:env.get("BACKEND_URL")! + url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: urlInstance)
            request.httpMethod = "PUT"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(.requestFailed))
                        return
                        }
            
            guard let data = data else {
                completion(.success(nil))
                return
            }
            
            guard let dictData = try? JSONSerialization.jsonObject(with: data , options: []) as? Dictionary<String, Any>else{
                completion(.failure(.invalidReponseData))
                return
            }
            completion(.success(dictData))
        }
        
        task.resume()
    }
    
    func delete(url: String,completion: @escaping (Result<Dictionary<String, Any>?, APIError>) -> Void) {
        guard let urlInstance = URL(string:env.get("BACKEND_URL")! + url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: urlInstance)
            request.httpMethod = "DELETE"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Request failed with error: \(error.localizedDescription)")
                completion(.failure(.requestFailed))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                        completion(.failure(.requestFailed))
                        return
                        }
            
            guard let data = data else {
                completion(.success(nil))
                return
            }
            
            guard let dictData = try? JSONSerialization.jsonObject(with: data , options: []) as? Dictionary<String, Any>else{
                completion(.failure(.invalidReponseData))
                return
            }
            completion(.success(dictData))
        }
        
        task.resume()
    }
}
