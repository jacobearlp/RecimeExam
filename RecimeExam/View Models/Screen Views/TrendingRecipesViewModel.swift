//
//  TrendingRecipesViewModel.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import Foundation
import Combine

class TrendingRecipesViewModel: ObservableObject {

    @Published var recipeItems: [RecipeItemModel]
    @Published var showDifficultyActionSheet = false
    @Published var selectedDifficultyFilter: RecipeItemModel.Difficulty? = nil

    private var subscribers: [AnyCancellable] = []
    private var apiManager: APIServicable

    init(apiManager: APIServicable, recipeItems: [RecipeItemModel] = []) {
        self.apiManager = apiManager
        self.recipeItems = recipeItems
    }

    func getRecipes() {
        apiManager.getTrendingRecipes()
            .receive(on: DispatchQueue.main)
            .sink { error in
            } receiveValue: { recipes in
                self.recipeItems = recipes.map { RecipeItemModel(recipeModel: $0) }
            }
            .store(in: &subscribers)
    }

    func filterButtonTapped() {
        showDifficultyActionSheet = true
    }

    func sortRecipeByDifficulty(difficulty: RecipeItemModel.Difficulty? = nil) {
        selectedDifficultyFilter = difficulty
        guard let difficulty else {
            recipeItems = recipeItems.sorted(by: { $0.position < $1.position })
            return
        }
        let prioritizedRecipes = recipeItems.filter { $0.difficulty == difficulty }
        let otherRecipes = recipeItems.filter { $0.difficulty != difficulty }
            .sorted(by: { $0.difficulty.priorityNumber < $1.difficulty.priorityNumber })
        let newRecipes = prioritizedRecipes + otherRecipes
        recipeItems = newRecipes
    }
}
