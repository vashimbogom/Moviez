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
        XCTAssertTrue(moviesListViewModel.pageNumber == 1)
        mockShowTrendingMoviesUseCase.response = MovieViews_Previews.moviesPage
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 20)
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Deadpool & Wolverine")
        XCTAssertTrue(moviesListViewModel.pageNumber == 2)
        XCTAssertFalse(moviesListViewModel.shouldShowLoader())
    }
    
    func testMoviesListViewModelFailure() async throws {
        mockShowTrendingMoviesUseCase.error = ServiceError.failed
        XCTAssertTrue(moviesListViewModel.pageNumber == 1)
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 0)
        XCTAssertTrue(moviesListViewModel.pageNumber == 1)
        XCTAssertNotNil(moviesListViewModel.error)
        XCTAssertEqual(moviesListViewModel.error, ServiceError.failed.description)
        XCTAssertTrue(moviesListViewModel.isError)
    }
    
    func testMoviesListViewModel_sortMovies_Success() async throws {
        mockShowTrendingMoviesUseCase.response = MovieViews_Previews.moviesPage
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 20)
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Deadpool & Wolverine")
        moviesListViewModel.sortMovies()
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "A Quiet Place: Day One")
        moviesListViewModel.sortMovies()
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Uglies")
    }
    
    func testMoviesListViewModel_searchMovie_Success() async throws {
        mockShowTrendingMoviesUseCase.response = MovieViews_Previews.moviesPage
        await moviesListViewModel.fetchMovies()
        XCTAssertTrue(moviesListViewModel.movies.count == 20)
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Deadpool & Wolverine")
        moviesListViewModel.searchInFetchedMoviesWithTitleLike("A Quiet Place")
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "A Quiet Place: Day One")
        moviesListViewModel.searchInFetchedMoviesWithTitleLike("")
        XCTAssertEqual(moviesListViewModel.movies.first?.title, "Deadpool & Wolverine")
    }
}
