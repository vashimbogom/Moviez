//
//  Endpoint.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    var params: [String: Any]? { get }
}
