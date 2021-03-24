//
//  HTTPNetworkError.swift
//  ArtistsFromiTunes
//
//  Created by Raj Mandavilli on 3/23/21.
//

import Foundation

// The enumeration defines possible errrors to encounter during Network Request
enum HTTPNetworkError: Error {
    case encodingFailed
    case decodingFailed
    case missingURL
    case noNetwork
    case parametersInvalid
    case serverSideError
    case requestFailure
    case gatewayTimeout
    case forbidden
}

extension HTTPNetworkError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .encodingFailed:
            return NSLocalizedString("Error Found : Parameter Encoding failed.", comment: "")
        case .decodingFailed:
            return NSLocalizedString("Error Found : Unable to Decode the data.", comment: "")
        case .missingURL:
            return NSLocalizedString("Error Found : The URL is nil.", comment: "")
        case .noNetwork:
            return NSLocalizedString("Please check your network connection and try again.", comment: "")
        case .parametersInvalid:
            return NSLocalizedString("Error Found : Network Request Parameters are invalid.", comment: "")
        case .serverSideError:
            return NSLocalizedString("Unable to process your request at this time.  Please try again later.", comment: "")
        case .requestFailure:
            return NSLocalizedString("Unable to process your request at this time. Please try again later.", comment: "")
        case .gatewayTimeout:
            return NSLocalizedString("Unable to process your request at this time. Please try again later.", comment: "")
        case .forbidden:
            return NSLocalizedString("Unable to process your request at this time. Please try again later.", comment: "")
        }
    }
}
