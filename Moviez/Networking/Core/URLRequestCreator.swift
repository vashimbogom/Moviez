//
//  URLRequestCreator.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

protocol URLRequestGenerator {
    func generateURLRequest(with config: ServiceConfigurable, from request: NetworkRequest) throws -> URLRequest
}

final class DefaultURLRequestGenerator: URLRequestGenerator {
    
    /// Method to create URLRequest
    /// - Parameters:
    ///   - config: Network Config
    ///   - request: Network Request
    /// - Returns: URLRequest
    func generateURLRequest(with config: ServiceConfigurable, from request: NetworkRequest) throws -> URLRequest {
        let url = try createURL(with: config, from: request)
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10)
        urlRequest.httpMethod = request.method.rawValue
        if !request.bodyParameters.isEmpty {
            do {
                let bodyData = try JSONSerialization.data(withJSONObject: request.bodyParameters,
                                                          options: [.prettyPrinted])
                urlRequest.httpBody = bodyData
            } catch {
                throw error
            }
        }
        config.headers.forEach { key, value in
            urlRequest.setValue(value, forHTTPHeaderField: key)
        }
        return urlRequest
    }
    
    /// Method to ceate URL
    /// - Parameters:
    ///   - config: Network Config
    ///   - request: Network Request
    /// - Returns: URL
    private func createURL(with config: ServiceConfigurable, from request: NetworkRequest) throws -> URL {
        var components = URLComponents()
        components.scheme = EnvironmentConfiguration.hostScheme
        components.host = config.baseURL
        components.path = request.path
        components.queryItems = request.queryParameters.map { URLQueryItem(name: $0, value: "\($1)") }
        guard let url = components.url else { throw ServiceError.badURL }
        return url
    }
}
