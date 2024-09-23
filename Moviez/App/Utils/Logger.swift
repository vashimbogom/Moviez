//
//  Logger.swift
//  Moviez
//
//  Created by Lord Jose Lopez on 23/09/24.
//

import Foundation

final class Log {
    
    static func error(_ object: Any...){
        message("Error‼️", object)
    }
    
    static func error(_ object: Any){
        message("Error‼️", object)
    }
    
    static func info(_ object: Any...){
        message("Info ℹ️", object)
    }
    
    static func info(_ object: Any){
        message("Info ℹ️", object)
    }
    
    private static func message(_ message: String, _ object: Any...){
        if EnvironmentConfiguration.appEnvironment != .Prod {
            print(message)
            for item in object {
                print(item)
            }
        }
    }
    
    private static func message(_ message: String, _ object: Any){
        if EnvironmentConfiguration.appEnvironment != .Prod {
            print(message)
            print(object)
        }
    }
}
