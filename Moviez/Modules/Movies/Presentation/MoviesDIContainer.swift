//
//  MoviesDIContainer.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 22/09/24.
//

import Foundation

class MoviesDIContainer {
    
    lazy private var apiDataTransferService: DataTransferService = {
        let config = ApiDataNetworkConfig(baseURL: EnvironmentConfiguration.hostURL, headers: EnvironmentConfiguration.headers)
        let sessionManager = DefaultServiceSessionManager(session: SharedURLSession.shared)
        let networkManager = DefaultServiceManager(config: config, sessionManager: sessionManager)
        return DefaultDataTransferService(networkManager: networkManager)
    }()
    
    //MARK: - Movie List Views
    
    lazy var TrendingMoviesList: TrendingMoviesListView = {
        let moviesModule = MoviesModule(apiDataTransferService: apiDataTransferService)
        return moviesModule.generateTrendingMoviesListView()
    }()

}
