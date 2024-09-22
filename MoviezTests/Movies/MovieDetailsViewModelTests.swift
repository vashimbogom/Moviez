//
//  MovieDetailsViewModelTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class MovieDetailsViewModelTests: XCTestCase {
    
    var movieDetailsViewModel: MovieDetailsViewModel!
    var mockShowMovieDetailsUseCase: MockShowMovieDetailsUseCase!
    
    override func setUp() async throws {
        try await super.setUp()
        mockShowMovieDetailsUseCase = MockShowMovieDetailsUseCase()
        movieDetailsViewModel = MovieDetailsViewModel(movieID: 533535, useCase: mockShowMovieDetailsUseCase)
    }
    
    override func tearDown() {
        super.tearDown()
        movieDetailsViewModel = nil
        mockShowMovieDetailsUseCase = nil
    }

    func testMoviesListViewModelSuccess() async throws {
        XCTAssertTrue(movieDetailsViewModel.shouldShowLoader())
        mockShowMovieDetailsUseCase.response = MovieViews_Previews.movieDetailsDomain
        await movieDetailsViewModel.fetchMovieDetails()
        XCTAssertTrue(movieDetailsViewModel.movieID == 533535)
        XCTAssertEqual(movieDetailsViewModel.movie.title, "Deadpool & Wolverine")
        XCTAssertFalse(movieDetailsViewModel.shouldShowLoader())
    }
    
    func testMoviesListViewModelFailure() async throws {
        mockShowMovieDetailsUseCase.error = ServiceError.failed
        await movieDetailsViewModel.fetchMovieDetails()
        XCTAssertTrue(movieDetailsViewModel.movie.id == 0)
        XCTAssertEqual(movieDetailsViewModel.movie.title, "")
        XCTAssertNotNil(movieDetailsViewModel.error)
        XCTAssertEqual(movieDetailsViewModel.error, ServiceError.failed.description)
        XCTAssertTrue(movieDetailsViewModel.isError)
    }
}
