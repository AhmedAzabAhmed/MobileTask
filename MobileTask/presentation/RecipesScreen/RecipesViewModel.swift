//
//  RecipesViewModel.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation
import Combine

final class RecipesViewModel {
    private var usecase: RecipesUsecaseProtocol
    let recipesList = PassthroughSubject<ScreenState<[RecipesModel]>, Never>()
    
    init(usecase: RecipesUsecaseProtocol = RecipesUsecase()) {
        self.usecase = usecase
    }
    
    func getRecipesList() {
        recipesList.send(.loading)
        Task {
            let result = await usecase.getRecipesList()
            switch result {
            case .success(let list):
                recipesList.send(.success(list))
                
            case .failure(let error):
                recipesList.send(.failure(error))
            }
        }
    }
}
