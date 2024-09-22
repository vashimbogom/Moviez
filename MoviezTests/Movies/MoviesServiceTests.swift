//
//  MoviesServiceTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class MoviesServiceTests: XCTestCase {

    var moviesService: MoviesService!
    var mockDataTransferService: MockDataTransferService!

    override func setUp() {
        super.setUp()
        mockDataTransferService = MockDataTransferService()
        moviesService = DefaultMoviesService(apiDataService: mockDataTransferService)
    }
    
    override func tearDown() {
        moviesService = nil
        mockDataTransferService = nil
        super.tearDown()
    }
    
    func testMoviesService_FetchTrendinMovies_Success() async throws {
        mockDataTransferService.response = MockData.moviesPage
        let moviesPage = try await moviesService.fetchTrendingMoviesList()
        XCTAssertEqual(moviesPage.results.count, 20)
    }

    func testMoviesService_FetchTrendinMovies_Failure() async throws {
        mockDataTransferService.error = NSError(domain: "FailedError", code: 0)
        do {
            _ = try await moviesService.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
