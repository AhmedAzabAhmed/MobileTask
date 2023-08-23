//
//  MockRecipeListUsecase.swift
//  MobileTaskTests
//
//  Created by Ahmed Azab on 23/08/2023.
//

import Foundation
@testable import MobileTask

class MockRecipeListUsecase: RecipesUsecaseProtocol {
    var result: Result<[MobileTask.RecipesModel], MobileTask.APIErrors> = .success([RecipesModel(id: "1", name: "test", image: "image", description: "nice", ingredients: ["eggs"])])
    func getRecipesList() async -> Result<[MobileTask.RecipesModel], MobileTask.APIErrors> {
        return result
    }
}
