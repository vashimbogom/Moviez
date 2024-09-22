//
//  URLRequestCreaterTests.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import XCTest
@testable import Moviez

final class URLRequestCreatorTests: XCTestCase {

    var requestGenerator: URLRequestGenerator!
    
    override func setUp() {
        super.setUp()
        requestGenerator = DefaultURLRequestGenerator()
    }
    
    override func tearDown() {
        requestGenerator = nil
        super.tearDown()
    }
    
    func testURLRequest() {
        do {
            let urlRequest = try requestGenerator.generateURLRequest(with: MockApiDataNetworkConfig(), from: MockNetworkRequest())
            XCTAssertEqual(urlRequest.url?.host, "mockmovies.com")
            XCTAssertEqual(urlRequest.url?.scheme, "https")
            XCTAssertEqual(urlRequest.url?.path, "/movies")
            XCTAssertEqual(urlRequest.url, URL(string: "https://mockmovies.com/movies?page=1"))
            XCTAssertEqual(urlRequest.httpMethod, HTTPMethod.get.rawValue)
            XCTAssertEqual(urlRequest.allHTTPHeaderFields, ["Content-Type":"application/json"])
            XCTAssertNil(urlRequest.httpBody)
        } catch {
            XCTFail("Request Failed unexpectedly")
        }
    }
}
