//
//  ShowTrendingMoviesUseCaseTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class ShowTrendingMoviesUseCaseTests: XCTestCase {
    
    var showTrendingMoviesUseCase: ShowTrendingMoviesUseCase!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        showTrendingMoviesUseCase = DefaultShowTrendingMoviesUseCase(repository: mockMoviesRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        showTrendingMoviesUseCase = nil
        mockMoviesRepository = nil
    }

    func testShowTrendingMoviesSuccess() async throws {
        mockMoviesRepository.moviesListesponse = MovieViews_Previews.moviesPage
        let trendinMoviesList = try await showTrendingMoviesUseCase.fetchTrendingMoviesList()
        XCTAssertNotNil(trendinMoviesList)
    }
    
    func testShowTrendingMoviesFailure() async throws {
        mockMoviesRepository.error = ServiceError.failed
        do {
            _ = try await showTrendingMoviesUseCase.fetchTrendingMoviesList()
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
}
