

import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case invalidReponseData
    case invalidEnv
}


class APIManager {
    static let request = APIManager()
    
    func get(url: String, completion: @escaping (Result<Data,APIError>) -> Void){
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else{
            completion(.failure(.invalidEnv))
            return
        }
        guard let urlInstance = URL(string:BACKEND_URL + url) else {
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
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func post(url: String, data: Dictionary<String, Any>, completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            completion(.failure(.invalidData))
            return
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else{
            completion(.failure(.invalidEnv))
            return
        }
        guard let urlInstance = URL(string:BACKEND_URL + url) else {
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
        
            completion(.success(data))
            
        }
        
        task.resume()
    }
    
    func put(url: String, data: Dictionary<String, Any>, completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            completion(.failure(.invalidData))
            return
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else{
            completion(.failure(.invalidEnv))
            return
        }
        guard let urlInstance = URL(string:BACKEND_URL + url) else {
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
            completion(.success(data))
        }
        
        task.resume()
    }
    
    func delete(url: String,completion: @escaping (Result<Data?, APIError>) -> Void) {
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else{
            completion(.failure(.invalidEnv))
            return
        }
        guard let urlInstance = URL(string:BACKEND_URL + url) else {
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
        
            completion(.success(data))
        }
        
        task.resume()
    }
}
