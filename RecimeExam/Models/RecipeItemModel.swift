//
//  RecipeItemModel.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import Foundation

struct RecipeItemModel {
    var id: Int
    var title: String
    var imageURL: URL
    var position: Int
    var difficulty: Difficulty

    enum Difficulty: String, CaseIterable {
        case easy, medium, hard

        var priorityNumber: Int {
            switch self {
            case .easy: return 1
            case .medium: return 2
            case .hard: return 3
            }
        }
    }

    init(id: Int, title: String, imageURL: URL, position: Int, difficulty: Difficulty) {
        self.id = id
        self.title = title
        self.imageURL = imageURL
        self.position = position
        self.difficulty = difficulty
    }

    init(recipeModel: RecipeModel) {
        self.init(id: recipeModel.id, title: recipeModel.title, imageURL: recipeModel.imageUrl, position: recipeModel.position, difficulty: Difficulty(rawValue: recipeModel.difficulty) ?? .easy)
    }
}
