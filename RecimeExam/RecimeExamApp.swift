//
//  RecimeExamApp.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import SwiftUI

@main
struct RecimeExamApp: App {

    @StateObject var trendingRecipeViewModel = TrendingRecipesViewModel(apiManager: APIManager())

    var body: some Scene {
        WindowGroup {
            TrendingRecipesView(viewModel: trendingRecipeViewModel)
        }
    }
}
