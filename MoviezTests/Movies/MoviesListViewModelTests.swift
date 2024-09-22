//
//  MoviesListViewModelTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class MoviesListViewModelTests: XCTestCase {
    
    var moviesListViewModel: MoviesListViewModel!
    var mockShowTrendingMoviesUseCase: MockShowTrendingMoviesUseCase!
    
    override func setUp() async throws {
        try await super.setUp()
        mockShowTrendingMoviesUseCase = MockShowTrendingMoviesUseCase()
        moviesListViewModel = MoviesListViewModel(useCase: mockShowTrendingMoviesUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        moviesListViewModel = nil
        mockShowTrendingMoviesUseCase = nil
    }

    func testMoviesListViewModelSuccess() async throws {
        XCTAssertTrue(moviesListViewModel.shouldShowLoader())
        mockShowTrendingMoviesUseCase.response = MockData.moviesPage
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 20)
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Deadpool & Wolverine")
        XCTAssertFalse(moviesListViewModel.shouldShowLoader())
    }
    
    func testMoviesListViewModelFailure() async throws {
        mockShowTrendingMoviesUseCase.error = ServiceError.failed
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 0)
        XCTAssertNotNil(moviesListViewModel.error)
        XCTAssertEqual(moviesListViewModel.error, ServiceError.failed.description)
        XCTAssertTrue(moviesListViewModel.isError)
    }
}
