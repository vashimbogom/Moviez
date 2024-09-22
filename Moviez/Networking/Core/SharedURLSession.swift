//
//  SharedURLSession.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

final class SharedURLSession {
    
    static var shared: URLSession {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedURLSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: nil)
    }
}
