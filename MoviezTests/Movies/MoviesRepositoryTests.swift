//
//  MoviesRepositoryTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class MoviesRepositoryTests: XCTestCase {
    
    var moviesRepository: MoviesRepository!
    var mockMoviesService: MockMoviesService!
    
    override func setUp() {
        super.setUp()
        mockMoviesService = MockMoviesService()
        moviesRepository = DefaultMoviesRepository(service: mockMoviesService)
    }
    
    override func tearDown() {
        super.tearDown()
        moviesRepository = nil
        mockMoviesService = nil
    }

    func testProductRepositorySuccess() async throws {
        mockMoviesService.response = MockData.moviesPage
        let moviesList = try await moviesRepository.fetchTrendingMoviesList()
        XCTAssertNotNil(moviesList)
    }
    
    func testProductRepositoryFailure() async throws {
        mockMoviesService.error = ServiceError.failed
        do {
            _ = try await moviesRepository.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
}
