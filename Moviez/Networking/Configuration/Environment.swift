//
//  Environment.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 21/09/24.
//

import Foundation

enum Env: String {
    case Prod = "PROD"
    case Dev = "DEV"
    case Mock = "MOCK"
    
    init(fromRawValue: String) {
        self = Env(rawValue: fromRawValue) ?? .Mock
    }
}
