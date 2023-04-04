//
//  RecipesResponseModel.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import Foundation

struct RecipesResponseModel {
    var recipes: [RecipeModel]
}

extension RecipesResponseModel: Codable {
    enum CodingKeys: String, CodingKey {
        case recipes
    }
}
