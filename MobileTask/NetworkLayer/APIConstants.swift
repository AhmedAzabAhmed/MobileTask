//
//  APIConstants.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

struct APIConstants {
    static var baseUrl: String = "https://api.npoint.io/"
    
    enum Errors: Error {
        case genericError
        case parseError
    }
}
