//
//  MockDataTransferService.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation
@testable import Moviez

final class MockDataTransferService: DataTransferService {
        
    var response: Decodable?
    var error: Error?
    
    func request<T>(for endpoint: any Moviez.Endpoint) async throws -> T where T : Decodable {
        if let error {
            throw error
        }
        return response as! T
    }
    
    func request<T>(request: Moviez.NetworkRequest) async throws -> T where T : Decodable {
        if let error {
            throw error
        }
        return response as! T
    }
}
