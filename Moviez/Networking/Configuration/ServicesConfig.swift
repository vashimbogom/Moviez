//
//  ServicesConfig.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

protocol ServiceConfigurable {
    var baseURL: String { get }
    var headers: [String: String] { get }
}

class ApiDataNetworkConfig: ServiceConfigurable {
    
    let baseURL: String
    let headers: [String: String]
    
     init(baseURL: String,
        headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.headers = headers
    }
}
