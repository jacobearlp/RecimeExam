//
//  RecipeItemMockView.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import Foundation

class RecipeItemMockView {
    static let chickenBurger = RecipeItemModel(
        id: 1,
        title: "Chicken Burger",
        imageURL: Constants.burgerImageURL,
        position: 1,
        difficulty: .easy)

    static let beefBurger = RecipeItemModel(
        id: 1,
        title: "Beef Burger",
        imageURL: Constants.burgerImageURL,
        position: 1,
        difficulty: .easy)

    static let veganBurger = RecipeItemModel(
        id: 1,
        title: "Vegan Burger",
        imageURL: Constants.burgerImageURL,
        position: 1,
        difficulty: .easy)
}
