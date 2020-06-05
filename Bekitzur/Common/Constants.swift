import Foundation
import UIKit

struct Constants {

}

public enum APIError: Error {
    case cannotParse
    case unknownError
    case connectionError
    case invalidCredentials
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case timeOut
    case unsupportedURL
    case mailExist

    static func checkErrorCode(_ errorCode: Int) -> APIError {
        switch errorCode {
        case 401:
            return .invalidCredentials
        case 404:
            return .notFound
        case 409:
            return .mailExist
        default:
            return .unknownError
        }
    }
}
