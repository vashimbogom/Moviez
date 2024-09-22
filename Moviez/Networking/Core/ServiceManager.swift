//
//  ServiceManager.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

protocol ServiceSessionManager {
    func request(with config: ServiceConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?)
}
protocol ServiceManager {
    func fetch(request: NetworkRequest) async throws -> Data
}

final class DefaultServiceManager: ServiceManager {
    
    private let config: ServiceConfigurable
    private let sessionManager: ServiceSessionManager
    
    init(config: ServiceConfigurable,
         sessionManager: ServiceSessionManager = DefaultServiceSessionManager()) {
        self.config = config
        self.sessionManager = sessionManager
    }
    
    /// Method to fetch data from Session Manager and validates the data and response
    /// - Parameter request: Network Request
    /// - Returns: Data
    func fetch(request: NetworkRequest) async throws -> Data {
        let (data, response) = try await sessionManager.request(with: config, request: request)
        guard let response = response as? HTTPURLResponse else { throw ServiceError.noResponse }
        if response.statusCode != 200 { throw ServiceError.failed }
        guard let data = data else { throw ServiceError.noData }
        return data
    }
}
