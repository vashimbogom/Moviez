//
//  ShowMovieDetailsUseCaseTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class ShowMovieDetailsUseCaseTests: XCTestCase {
    
    var showMovieDetailsUseCase: ShowMovieDetailsUseCase!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        showMovieDetailsUseCase = DefaultShowMovieDetailsUseCase(repository: mockMoviesRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        showMovieDetailsUseCase = nil
        mockMoviesRepository = nil
    }

    func testShowMovieDetailsSuccess() async throws {
        mockMoviesRepository.movieDetailsResponse = MovieViews_Previews.movieDetailsDomain
        let movieDetails = try await showMovieDetailsUseCase.fetchMovieDetails(movieID: 13)
        XCTAssertNotNil(movieDetails)
    }
    
    func testShowMovieDetailsFailure() async throws {
        mockMoviesRepository.error = ServiceError.failed
        do {
            _ = try await showMovieDetailsUseCase.fetchMovieDetails(movieID: 13)
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
}
