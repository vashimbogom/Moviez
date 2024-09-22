//
//  ServiceSessionManagerTests.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import XCTest
@testable import Moviez

final class ServiceSessionManagerTests: XCTestCase {

    var serviceSessionManger: ServiceSessionManager!
    var mockURLSession: MockURLSession!
    var response: HTTPURLResponse {
        return HTTPURLResponse(url: URL(string: "/movie")!,
                               statusCode: 200,
                               httpVersion: nil,
                               headerFields: nil)!
    }
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        serviceSessionManger = DefaultServiceSessionManager(session: mockURLSession)
    }

    override func tearDown() {
        super.tearDown()
        serviceSessionManger = nil
    }
    
    func testRequestSuccessResponse() async throws {
        mockURLSession.data = MockDataProvider.entitiesRawData
        mockURLSession.urlResponse = response
        do {
            let (data,response) = try await mockURLSession.asyncData(for: URLRequest(url: MockDataProvider.mockURL))
            XCTAssertNotNil(data)
            XCTAssertNotNil(response)
        } catch {
            XCTFail("Should not fail")
        }
    }
    
    func testFailerCase() async throws {
        mockURLSession.error = NSError(domain: "Failed", code: 0)
        do {
            let (_,_) = try await mockURLSession.asyncData(for: URLRequest(url: MockDataProvider.mockURL))
            XCTFail("Should not succeed")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
