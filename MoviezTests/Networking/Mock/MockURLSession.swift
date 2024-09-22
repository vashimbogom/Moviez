//
//  MockURLSession.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
@testable import Moviez

class MockURLSession: URLSessionProtocol {
    var data: Data?
    var urlResponse: URLResponse?
    var error: Error?
    func asyncData(for request: URLRequest) async throws -> (Data?, URLResponse?) {
        if let error {
            throw error
        }
        return (data, urlResponse)
    }
}


