//
//  RecipesDataModel.swift
//  MobileTask
//
//  Created by Ahmed Azab on 19/08/2023.
//

import Foundation

// MARK: - RecipesDataModel
struct RecipesDataModel: Codable {
    let id: String?
    let fats: String?
    let name: String?
    let image: String?
    let carbos: String?
    let rating: Double?
    let country: String?
    let ratings: Int?
    let calories: String?
    let headline: String?
    let proteins: String?
    let favorites: Int?
    let description: String?
    let ingredients: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fats
        case name
        case image
        case carbos
        case rating
        case country
        case ratings
        case calories
        case headline
        case proteins
        case favorites
        case description
        case ingredients
    }
}
