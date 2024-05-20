
import Foundation

enum CustomDataError:Error{
    case invalidChoreId
    case invalidGroceryId
    case invalidGroupId
    case invalidUserId
    case envError
    case invalidDataForJSON
    case invalidJSONForData
    case invalidInputdata
    case error(String)
}


extension CustomDataError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidChoreId:
            return "Invalid Chore Id"
        case .invalidGroceryId:
            return "Invalid Grocery Id"
        case .invalidGroupId:
            return "Inavlid Group Id"
        case .invalidUserId:
            return "Invalid User Id"
        case .envError:
            return "Cannot load env data."
        case .invalidDataForJSON:
            return "Cannot convert data to JSON."
        case .invalidJSONForData:
            return "Cannot convert JSON to data."
        case .invalidInputdata:
            return "Invalid Input Data"
        case .error(let message):
            return message
        }
    }
}

