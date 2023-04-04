//
//  RecipeItemView.swift
//  RecimeExam
//
//  Created by Jacob on 4/4/23.
//

import SwiftUI

struct RecipeItemView: View {
    var recipe: RecipeItemModel
    var imageSize: CGSize
    var isHightlighted: Bool

    var body: some View {
        VStack {
            AppCachedAsyncImage(url: Constants.burgerImageURL) { image in
                image
                    .resizable()
                    .frame(width: imageSize.width, height: imageSize.height)
                    .scaledToFill()
            } placeholder: {
                ProgressView()
                    .frame(width: imageSize.width, height: imageSize.height)
            }

            HStack {
                Text(recipe.title)
                    .font(.headline)
                    .foregroundColor(isHightlighted ? .blue : .black)
                Spacer()
            }
            .padding(.horizontal, 10)

            HStack {
                Text(recipe.difficulty.rawValue.capitalized)
                    .foregroundColor(.gray)
                    .font(.headline)
                Spacer()
            }
            .padding([.bottom, .horizontal], 10)
        }
        .frame(width: imageSize.width)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(isHightlighted ? .blue : .black, lineWidth: 3)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

struct RecipeItemView_Previews: PreviewProvider {
    static var previews: some View {
        let spacing: CGFloat = 20
        let geo = CGSize(width: Constants.fullScreenWidth, height: Constants.fullScreenHeight)
        let imageWidth = (geo.width - spacing) / 2
        let imageSize = CGSize(width: imageWidth, height: 250)
        HStack(spacing: 10) {
            RecipeItemView(recipe: RecipeItemMockView.chickenBurger, imageSize: imageSize, isHightlighted: true)
            RecipeItemView(recipe: RecipeItemMockView.beefBurger,imageSize: imageSize, isHightlighted: false)
        }
    }
}
