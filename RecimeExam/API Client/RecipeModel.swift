//
//  RecipeModel.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import Foundation

struct RecipeModel {
    var id: Int
    var title: String
    var imageUrl: URL
    var position: Int
    var difficulty: String

    init(id: Int, title: String, imageUrl: URL, position: Int, difficulty: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.position = position
        self.difficulty = difficulty
    }
}

extension RecipeModel: Codable {
    enum CodingKeys: String, CodingKey {
        case id, title, imageUrl, position, difficulty
    }
}
