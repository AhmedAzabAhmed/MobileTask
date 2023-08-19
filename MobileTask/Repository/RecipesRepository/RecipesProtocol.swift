//
//  RecipesProtocol.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

protocol RecipesProtocol {
    func getRecipesList() async -> Result<[RecipesDataModel], APIErrors>
}
