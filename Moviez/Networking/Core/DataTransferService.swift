//
//  DataTransferService.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
import UIKit

protocol DataTransferService {
    func request<T: Decodable>(for endpoint: Endpoint) async throws -> T
}

final class DefaultDataTransferService: DataTransferService {
    
    private let networkManager: ServiceManager
    init(networkManager: ServiceManager) {
        self.networkManager = networkManager
    }
    
    /// Method to fetch data from Network Manager or local mock resource according to envr¿ironment settings and return Decoded  data
    /// - Parameter request:  Network request
    /// - Returns: Decodable type object
    func request<T>(for endpoint: Endpoint) async throws -> T where T : Decodable {
        if EnvironmentConfiguration.appEnvironment == .Mock {
            return try requestMock(resourceName: endpoint.path)
        } else {
            let queryParams: [String: Any] = endpoint.params ?? [:]
            let headers: [String: String] = endpoint.headers ?? [:]
            
            let networkRequest = DefaultNetworkRequest(path: endpoint.path , method: endpoint.method, headerParameters: headers, queryParameters: queryParams)
            return try await request(request: networkRequest)
        }
    }
    
    /// Method to fetch data from Network Manager and Decode the data using decode method
    /// - Parameter request:  Network request
    /// - Returns: Decodable type object
    func request<T>(request: NetworkRequest) async throws -> T where T : Decodable {
        let data = try await networkManager.fetch(request: request)
        return try decode(data: data)
    }
    
    /// Method to load mock data from local resources and Decode the data using decode method
    /// - Parameter resourceName:  The name of the json mock resource
    /// - Returns: Decodable type object
    func requestMock<T>(resourceName: String) throws -> T where T : Decodable {
        
        if let asset = NSDataAsset(name: resourceName, bundle: Bundle.main) {
            return try decode(data: asset.data)
        } else {
            throw ServiceError.unableToDecode
        }
    }
    
    /// Method to decode data using JSONDecoder
    /// - Parameter data: Data
    /// - Returns: Decodable type object
    func decode<T>(data: Data) throws -> T where T : Decodable {
        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw ServiceError.unableToDecode
        }
    }
}
