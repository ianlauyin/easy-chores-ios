
import Foundation

enum APIError: Error {
    case invalidURL
    case requestFailed
    case invalidResponse
    case invalidData
    case invalidReponseData
    case invalidEnv
    case invalidKeychainData
}
