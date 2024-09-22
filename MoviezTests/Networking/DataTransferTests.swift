//
//  DataTransferTests.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import XCTest
@testable import Moviez

final class DataTransferTests: XCTestCase {

    var dataTransferService: DataTransferService!
    var networkManager: MockServiceManager!
    
    override func setUp() {
        super.setUp()
        networkManager = MockServiceManager()
        dataTransferService = DefaultDataTransferService(networkManager: networkManager)
    }

    override func tearDown() {
        super.tearDown()
        networkManager = nil
        dataTransferService = nil
    }
    
    func testRequestSuccessResponse() async throws {
        networkManager.data = MockDataProvider.entitiesRawData
        let request = DefaultNetworkRequest(path: "/movies")
        let EntityPage = try await getEntityData(request: request)
        XCTAssertEqual(EntityPage.data.count, 3)
    }
    
    func getEntityData(request: NetworkRequest) async throws -> MockEntityListDTO {
        try await dataTransferService.request(for: MockEndpoints.something)
    }
    
    func testRequestFailureCase() async throws {
        networkManager.error = NSError(domain: "Failed", code: 0)
        let request = DefaultNetworkRequest(path: "/movies")
        do {
           _ = try await getEntityData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testDecodingFailureCase() async throws {
        networkManager.data = Data()
        let request = DefaultNetworkRequest(path: "/movies")
        do {
           _ = try await getEntityData(request: request)
            XCTFail("Should not succeed")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.unableToDecode)
        }
    }
}

