import Foundation

enum AppError: Error, LocalizedError {

    case badRequestData
    case badUrl
    case endpointError(message: String)
    case emptyResponseData
    case unDecodableResponse
    case unknownError
    case networkError

    public var errorDescription: String? {
        switch self {
        case .badRequestData:
            return "The correct data could not be sent"
        case .badUrl:
            return "Incorrect destination"
        case .endpointError(let message):
            return message
        case .emptyResponseData:
            return "Response is empty"
        case .unDecodableResponse:
            return "The response could not be decoded"
        case .unknownError:
            return "An error occurred"
        case .networkError:
            return "Check your internet connection"
        }
    }

}
