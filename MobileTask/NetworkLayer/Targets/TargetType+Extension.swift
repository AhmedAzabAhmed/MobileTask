//
//  TargetType+Extension.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Moya
import Foundation

extension TargetType {
    var baseURL: URL {
        return URL(string: APIConstants.baseUrl)!
    }

    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [:]
    }
}
