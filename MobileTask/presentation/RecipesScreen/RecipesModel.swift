//
//  RecipesModel.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

class RecipesModel {
    var id: String
    var name: String
    var image: String
    var description: String
    var ingredients: String
    var isFavorite: Bool
    
    init(id: String, name: String, image: String, description: String, ingredients: [String], isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
        self.isFavorite = isFavorite
        self.ingredients = ingredients.joined(separator: "\n")
    }
}
