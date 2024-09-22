//
//  MockServiceSessionManager.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
@testable import Moviez

class MockServiceSessionManager: ServiceSessionManager {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    func request(with config: ServiceConfigurable, request: NetworkRequest) async throws -> (Data?, URLResponse?) {
        if let error = self.error {
            throw error
        }
        return (data, response)
    }
}
