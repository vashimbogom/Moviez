//
//  MockServiceManager.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
@testable import Moviez

class MockServiceManager: ServiceManager {
    var data: Data?
    var error: Error?
    func fetch(request: NetworkRequest) async throws -> Data {
        if let error {
            throw error
        }
        return data!
    }
}
