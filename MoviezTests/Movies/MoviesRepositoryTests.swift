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

    func testMoviesRepository_fetchMoviesList_Success() async throws {
        mockMoviesService.movieListResponse = MovieViews_Previews.moviesPage
        let moviesList = try await moviesRepository.fetchTrendingMoviesList()
        XCTAssertNotNil(moviesList)
    }
    
    func testMoviesRepository_fetchMoviesList_Failure() async throws {
        mockMoviesService.error = ServiceError.failed
        do {
            _ = try await moviesRepository.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
    
    func testMoviesRepository_fetchPlayingNowMoviesList_Success() async throws {
        mockMoviesService.movieListResponse = MovieViews_Previews.moviesPage
        let moviesList = try await moviesRepository.fetchPlayingNowMoviesList(pageNumber: 13)
        XCTAssertNotNil(moviesList)
    }
    
    func testMoviesRepository_fetchPlayingNowMoviesList_Failure() async throws {
        mockMoviesService.error = ServiceError.failed
        do {
            _ = try await moviesRepository.fetchPlayingNowMoviesList(pageNumber: 13)
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
    
    func testMoviesRepository_fetchMovieDetails_Success() async throws {
        mockMoviesService.movieDetailsResponse = MovieViews_Previews.movieDetailsDomain
        let movieDetails = try await moviesRepository.fetchMovieDetails(movieID: 13)
        XCTAssertNotNil(movieDetails)
    }
    
    func testMoviesRepository_fetchMovieDetails_Failure() async throws {
        mockMoviesService.error = ServiceError.failed
        do {
            _ = try await moviesRepository.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
}
