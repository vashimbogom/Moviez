//
//  ServiceSessionManager.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

final class DefaultServiceSessionManager: ServiceSessionManager {
    
    private let session: URLSessionProtocol
    private let requestGenerator: URLRequestGenerator
    init(session: URLSessionProtocol = URLSession.shared,
         requestGenerator: URLRequestGenerator = DefaultURLRequestGenerator()) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    /// Method to get data and response from URLSession
    /// - Parameters:
    ///   - config: Network config
    ///   - request: Network request
    /// - Returns: Data and Response
    func request(with config: ServiceConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        let urlRequest = try requestGenerator.generateURLRequest(with: config, from: request)
        do {
            return try await session.asyncData(for: urlRequest)
        } catch {
            throw ServiceError.resolve(error: error)
        }
    }
}
