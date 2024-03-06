//
//  RequestError.swift
//  Dummy
//
//  Created by Sulay on 06/03/24.
//

import Foundation

public enum RequestError: Error {
    case failed(description: String)
    case decode(description: String)
    case invalidUrl
    case unauthorized
    
    var customDescription: String {
        switch self {
        case .failed(let description):
            return "Request Failed: \(description)"
        case .decode(let description):
            return "Decoding Error: \(description)"
        case .invalidUrl:
            return "Invalid URL"
        case .unauthorized:
            return "Session Expired"
        default:
            return "Unknown Error"
        }
    }
}
