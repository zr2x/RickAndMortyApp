//
//  NetworkConstant.swift
//  UfanetTestApp
//
//  Created by Искандер Ситдиков on 22.09.2023.
//

import Foundation

final class NetworkConstant {
    
    public static var shared: NetworkConstant = NetworkConstant()
    
    private init() { }
    
    public var serverAddress: String {
        get {
            "https://rickandmortyapi.com/"
        }
    }
    
    public var apiKey: String {
        get {
            "api/"
        }
    }
    
    public var character: String {
        get {
            "character"
        }
    }
}
