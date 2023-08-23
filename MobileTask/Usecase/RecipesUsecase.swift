//
//  RecipesUsecase.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

protocol RecipesUsecaseProtocol {
    func getRecipesList() async -> Result<[RecipesModel], APIErrors>
}

final class RecipesUsecase: RecipesUsecaseProtocol {
    private var recipesRepository: RecipesProtocol
    
    init(recipesRepository: RecipesProtocol = RecipesRepositoryImplementation()) {
        self.recipesRepository = recipesRepository
    }
    
    func getRecipesList() async -> Result<[RecipesModel], APIErrors> {
        let result = await recipesRepository.getRecipesList()
        do {
            let list  = try result.get()
            return .success(mapToRecipesModel(with: list))
        } catch {
            return .failure(.moyaFailure(description: error.localizedDescription))
        }
    }
    
    private func mapToRecipesModel(with list: [RecipesDataModel] ) -> [RecipesModel] {
        list.map { model in
            return RecipesModel (id: model.id ?? "", name: model.name ?? "", image: model.image ?? "", description: model.description ?? "", ingredients: model.ingredients ?? [])
        }
    }
}
