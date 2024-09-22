//
//  EnvironmentConfiguration.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

final class EnvironmentConfiguration {
    
    static let movieDBAPIToken: String = {
        guard let apiTokenKey = EnvironmentConfiguration.infoDictionary[ConfigurationKeys.APIToken] as? String else {
            fatalError("API Token Key not set")
        }
        return apiTokenKey
    }()
    
    static let appEnvironment: Env = {
        guard let environment = EnvironmentConfiguration.infoDictionary[ConfigurationKeys.Environment] as? String else {
            fatalError("Environment Key not set")
        }
        return Env(fromRawValue: environment)
    }()
    
    static var hostScheme: String = {
        guard let hostSheme = EnvironmentConfiguration.infoDictionary[ConfigurationKeys.HostSheme] as? String else {
            fatalError("Host Sheme Key not set")
        }
        return hostSheme
    }()
    
    static var hostURL: String = {
        guard let hostBaseURL = EnvironmentConfiguration.infoDictionary[ConfigurationKeys.HostBaseURL] as? String else {
            fatalError("Host Base URL Key not set")
        }
        return hostBaseURL
    }()
    
    static var imageURL: String = {
        guard let imgURL = EnvironmentConfiguration.infoDictionary[ConfigurationKeys.HostImageURL] as? String else {
            fatalError("Host Image URL Key not set")
        }
        return imgURL
    }()
    
    static var headers: [String: String] {
        [
            "accept": "application/json",
            "Authorization": "Bearer \(movieDBAPIToken)"
        ]
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Config file not found")
        }
        return dict
    }()
}

enum ConfigurationKeys {
    static let APIToken = "API_TOKEN"
    static let Environment = "APP_ENVIRONMENT"
    static let HostSheme = "HOST_SCHEME"
    static let HostBaseURL = "HOST_BASE_URL"
    static let HostImageURL = "HOST_IMAGE_URL"
}
