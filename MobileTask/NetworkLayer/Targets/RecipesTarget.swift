//
//  RecipesTarget.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Moya

enum RecipesTarget {
    case getRecipes
}

extension RecipesTarget: TargetType {
    var path: String {
        switch self {
        case .getRecipes:
            return APIConstants.recipesPath
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getRecipes:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getRecipes:
            return .requestPlain
        }
    }
}
