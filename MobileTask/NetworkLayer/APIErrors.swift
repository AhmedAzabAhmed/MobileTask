//
//  APIErrors.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

enum APIErrors: Error {
    case parseError(description: String)
    case moyaFailure(description: String)
    case genericError
}
