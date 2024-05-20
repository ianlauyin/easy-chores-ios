
import Foundation

enum APIError: Error {
    case invalidResponseData
    case invalidURL
    case requestFailed
    case invalidLoginData
    
}

extension APIError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidResponseData:
            return "Something wrong with the fetched Data."
        case .invalidURL:
            return "Invalid URL."
        case .requestFailed:
            return "Request is failed."
        case .invalidLoginData:
            return "Login Failed."
        }
    }
}
