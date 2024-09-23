//
//  ShowPlayingNowMoviesUseCaseTests.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import XCTest
@testable import Moviez

final class ShowPlayingNowMoviesUseCaseTests: XCTestCase {
    
    var showPlayingNowMoviesUseCase: ShowPlayingNowMoviesUseCase!
    var mockMoviesRepository: MockMoviesRepository!
    
    override func setUp() {
        super.setUp()
        mockMoviesRepository = MockMoviesRepository()
        showPlayingNowMoviesUseCase = DefaultShowPlayingNowMoviesUseCase(repository: mockMoviesRepository)
    }
    
    override func tearDown() {
        super.tearDown()
        showPlayingNowMoviesUseCase = nil
        mockMoviesRepository = nil
    }

    func testShowTrendingMoviesSuccess() async throws {
        mockMoviesRepository.moviesListesponse = MovieViews_Previews.moviesPage
        let trendinMoviesList = try await showPlayingNowMoviesUseCase.fetchPlayingNowMoviesList(pageNumber: 13)
        XCTAssertNotNil(trendinMoviesList)
    }
    
    func testShowTrendingMoviesFailure() async throws {
        mockMoviesRepository.error = ServiceError.failed
        do {
            _ = try await showPlayingNowMoviesUseCase.fetchPlayingNowMoviesList(pageNumber: 13)
            XCTFail("Success not expected")
        } catch {
            XCTAssertEqual(error as! ServiceError, ServiceError.failed)
        }
    }
}
