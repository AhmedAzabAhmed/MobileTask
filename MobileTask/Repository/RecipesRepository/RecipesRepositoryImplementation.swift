//
//  RecipesRepositoryImplementation.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation
import Moya

final class RecipesRepositoryImplementation: RecipesProtocol {
    func getRecipesList() async -> Result<[RecipesDataModel], APIErrors> {
        do {
            let baseModel = try await NetworkManager.shared.call(provider: MoyaProvider<RecipesTarget>(), target: .getRecipes, model: [RecipesDataModel].self)
            
            return .success(baseModel)
        } catch {
            return .failure(.parseError(description: error.localizedDescription))
        }
    }
}
