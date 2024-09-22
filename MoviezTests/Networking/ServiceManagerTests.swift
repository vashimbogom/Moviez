//
//  ServiceManagerTests.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import XCTest
@testable import Moviez

final class ServiceManagerTests: XCTestCase {

    var serviceManger: ServiceManager!
    var sessionManager: MockServiceSessionManager!
    
    var response = HTTPURLResponse(url: URL(string: "/movies")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    var invalidResponse = HTTPURLResponse(url: URL(string: "/xxxxx")!, statusCode: 400, httpVersion: nil, headerFields: nil)
    
    override func setUp() {
        super.setUp()
        sessionManager = MockServiceSessionManager()
        serviceManger = DefaultServiceManager(config: MockApiDataNetworkConfig(), sessionManager: sessionManager)
    }

    override func tearDown() {
        super.tearDown()
        serviceManger = nil
        sessionManager = nil
    }
    
    func testRequestSuccessResponse() async throws {
        sessionManager.data = MockDataProvider.entitiesRawData
        sessionManager.response = response
        let request = MockNetworkRequest()
        let data = try await getEntityData(request: request)
        XCTAssertNotNil(data)
    }
    
    func getEntityData(request: NetworkRequest) async throws -> Data {
        try await serviceManger.fetch(request: request)
    }
    
    func testRequestFailureCase() async throws {
        sessionManager.error = NSError(domain: "Failed", code: 0)
        let request = MockNetworkRequest()
        do {
           _ = try await getEntityData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testRequestFailedResponseCase() async throws {
        sessionManager.data = MockDataProvider.entitiesRawData
        sessionManager.response = invalidResponse
        let request = MockNetworkRequest()
        do {
           _ = try await getEntityData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
    
    func testEmptyResponseFailureCase() async throws {
        sessionManager.data = MockDataProvider.entitiesRawData
        let request = MockNetworkRequest()
        do {
           _ = try await getEntityData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.noResponse)
        }
    }
}
