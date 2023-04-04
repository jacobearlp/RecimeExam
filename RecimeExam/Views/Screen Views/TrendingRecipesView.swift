//
//  TrendingRecipesView.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import SwiftUI

struct TrendingRecipesView: View {

    @ObservedObject var viewModel: TrendingRecipesViewModel

    var body: some View {
        NavigationView {
            GeometryReader { geo in
                let imageWidth = (geo.size.width - (20)) / 2
                let imageSize = CGSize(width: imageWidth, height: 220)

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 0) {

                        Text("Trending Recipes")
                            .font(.viewTitle)
                            .padding(.bottom, 15)

                        ForEach(viewModel.recipeItems.indices, id: \.self) { index in
                            if index % 2 == 0 {
                                HStack(spacing: 0) {
                                    if let recipe = viewModel.recipeItems[index] {
                                        RecipeItemView(recipe: recipe, imageSize: imageSize, isHightlighted: viewModel.selectedDifficultyFilter == recipe.difficulty)
                                    }
                                    Spacer()
                                    if viewModel.recipeItems.count > index + 1,
                                       let recipe = viewModel.recipeItems[index + 1] {
                                        RecipeItemView(recipe: recipe, imageSize: imageSize, isHightlighted: viewModel.selectedDifficultyFilter == recipe.difficulty)
                                    }
                                }
                                Spacer()
                                    .frame(height: 20)
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Recipes")
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Filter", action: viewModel.filterButtonTapped)
                }
            }
            .actionSheet(isPresented: $viewModel.showDifficultyActionSheet, content: {
                ActionSheet(
                    title: Text("Difficulty"),
                    message: Text("You can filter recipes by difficulty"),
                    buttons: [
                        .cancel(Text("Cancel"), action: {
                            viewModel.sortRecipeByDifficulty(difficulty: nil)
                        }),
                        .default(Text("Easy"), action: {
                            viewModel.sortRecipeByDifficulty(difficulty: .easy)
                        }),
                        .default(Text("Medium"), action: {
                            viewModel.sortRecipeByDifficulty(difficulty: .medium)
                        }),
                        .default(Text("Hard"), action: {
                            viewModel.sortRecipeByDifficulty(difficulty: .hard)
                        })
                    ]
                )
            })
            .onAppear {
                viewModel.getRecipes()
            }
        }
    }
}

struct TrendingRecipesView_Previews: PreviewProvider {
    static func generateRecipeItemModels(limit: Int = 11) -> [RecipeItemModel] {
        var current = 1
        var recipes: [RecipeItemModel] = []
        while current <= limit {
            let difficulty = RecipeItemModel.Difficulty.allCases.randomElement() ?? .easy
            let recipe = RecipeItemModel(id: current, title: "Burger \(current)", imageURL: Constants.burgerImageURL, position: current, difficulty: difficulty)
            recipes.append(recipe)
            current += 1
        }
        return recipes
    }
    static var previews: some View {
        TrendingRecipesView(viewModel: TrendingRecipesViewModel(apiManager: APIManager(), recipeItems: generateRecipeItemModels()))
    }
}
