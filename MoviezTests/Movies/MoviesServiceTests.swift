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
    
    func testMoviesService_FetchTrendingMovies_Success() async throws {
        mockDataTransferService.response = MovieViews_Previews.moviesPage
        let moviesPage = try await moviesService.fetchTrendingMoviesList()
        XCTAssertEqual(moviesPage.results.count, 20)
    }

    func testMoviesService_FetchTrendingMovies_Failure() async throws {
        mockDataTransferService.error = NSError(domain: "FailedError", code: 0)
        do {
            _ = try await moviesService.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertNotNil(error)
        }
    }
    
    func testMoviesService_FetchMovieDetails_Success() async throws {
        mockDataTransferService.response = MovieViews_Previews.movieDetailsDomain
        let movieDetails = try await moviesService.fetchMovieDetail(movieID: 13)
        XCTAssertEqual(movieDetails.title, "Deadpool & Wolverine")
    }

    func testMoviesService_FetchMovieDetails_Failure() async throws {
        mockDataTransferService.error = NSError(domain: "FailedError", code: 0)
        do {
            _ = try await moviesService.fetchMovieDetail(movieID: 13)
            XCTFail("Success not expected")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
