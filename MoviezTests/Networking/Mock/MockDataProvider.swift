//
//  MockDataProvider.swift
//  MoviezTests
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation
@testable import Moviez

final class MockDataProvider {

    static var mockURL = URL(string: "https://moviez.com/something")!
    static var entitiesList: [MockEntityDTO] {
        return domainEntities
    }
    
    static var domainEntities: [MockEntityDTO] {
        return entitiesPage.data
    }
    
    static var entitiesPage: MockEntityListDTO {
        try! JSONDecoder().decode(MockEntityListDTO.self, from: entitiesRawData)
    }
    
    static var entitiesRawData: Data {
        loadJsonData("MockEntities")
    }
    
    private static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
}

struct MockEntityListDTO: Decodable {
    
    let page: Int
    let data: [MockEntityDTO]
    
}

struct MockEntityDTO: Decodable, Identifiable {
    
    let id: Int
    let name: String?
    let desc: String?
    
}

enum MockEndpoints {
    case something
    case notExistingResource
}

extension MockEndpoints: Endpoint {
    var path: String {
        switch(self) {
        case .something:
            "MockEntities"
        case .notExistingResource:
            "nothing"
        }
        
    }
    
    var method: Moviez.HTTPMethod {
        .get
    }

    var headers: [String : String]? {
        [:]
    }
    
    var params: [String : Any]? {
        [:]
    }
    
    
}
