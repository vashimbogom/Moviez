//
//  ServiceError.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

enum ServiceError: Error {
    case badURL
    case badHostname
    case failed
    case noResponse
    case noData
    case unableToDecode
    case notConnected
    case generic
    var description: String {
        switch self {
        case .badURL: return "Bad URL"
        case .badHostname: return "A server with the specified hostname could not be found"
        case .failed: return "Network Request Failed"
        case .noResponse: return "No response"
        case .noData: return "No Data found"
        case .unableToDecode: return "Response can not be decoded"
        case .notConnected: return "The internet connection appears to be offline"
        case .generic: return "Something misterious happened"
        }
    }
    
    static func resolve(error: Error) -> ServiceError {
        let code = URLError.Code(rawValue: (error as NSError).code)
        switch code {
        case .notConnectedToInternet: return .notConnected
        case .cannotFindHost: return .badHostname
        default: return .generic
        }
    }
}
