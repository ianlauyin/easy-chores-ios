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

    func get(url: String) async throws -> Data {
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw APIError.invalidEnv
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: urlInstance)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }

        return data
    }

    func post(url: String, data: Dictionary<String, Any>) async throws -> Data? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            throw APIError.invalidData
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw APIError.invalidEnv
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }

        return data
    }

    func put(url: String, data: Dictionary<String, Any>) async throws -> Data? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: data) else {
            throw APIError.invalidData
        }
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw APIError.invalidEnv
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }

        return data
    }

    func delete(url: String) async throws -> Data? {
        guard let BACKEND_URL = ProcessInfo.processInfo.environment["BACKEND_URL"] else {
            throw APIError.invalidEnv
        }
        guard let urlInstance = URL(string: BACKEND_URL + url) else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: urlInstance)
        request.httpMethod = "DELETE"

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw APIError.requestFailed
        }

        return data
    }
}
