//
//  MockNetworkRequest.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
@testable import Moviez

class MockNetworkRequest: NetworkRequest {
    var path = "/movies"
    var method = HTTPMethod.get
    var headerParameters: [String : String] = ["Content-Type":"application/json"]
    var queryParameters: [String : Any] = ["page":1]
    var bodyParameters: [String : Any] = [:]
}

class MockApiDataNetworkConfig: ServiceConfigurable {
    var baseURL: String = "mockmovies.com"
    var headers: [String : String] = ["Content-Type":"application/json"]
}
