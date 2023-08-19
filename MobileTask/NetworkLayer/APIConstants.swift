//
//  APIConstants.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

struct APIConstants {
    static var baseUrl: String = "https://api.npoint.io/"
    static let recipesPath = "43427003d33f1f6b51cc"
    
    enum Errors: Error {
        case genericError
        case parseError
    }
}
