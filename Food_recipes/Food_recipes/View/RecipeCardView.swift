//
//  RecipeCardView.swift
//  Food_recipes
//
//  Created by Noori on 29/10/2024.
//

import SwiftUI

struct RecipeCardView: View {
    let recipe: Recipe
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            if let image = recipe.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 414, height: 272)
                    .clipped()
            }
            
            // Shading overlay at the bottom
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.7)]),
                startPoint: .center,
                endPoint: .bottom
            )
            .frame(width: 414, height: 272)
            .clipped()
            
            // Text overlay with title, description, and "See All" link
            VStack(alignment: .leading, spacing: 1) {
                Text(recipe.title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(Color("discribtionColor"))
                
                HStack {
                    Text(recipe.description)
                        .font(.system(size: 12))
                        .foregroundColor(Color("discribtionColor"))
                        .lineLimit(2)
                    
                    NavigationLink(destination: RecipeDisplay_page(recipe: recipe)) { // Pass the specific recipe
                        Text("See All")
                            .font(.system(size: 12, weight: .bold))
                            .foregroundColor(Color.accentColor)
                            .padding(.top, 16)
                    }
                }
            }
            .padding([.leading, .trailing], 16)
            .padding(.bottom, 16)
        }
    }
}

//#Preview {
//    // Create a sample image (replace with an image from your assets if available)
//
//        // Create a sample recipe
//        let recipe = Recipe(
//            title: "Halomi Salad",
//            description: "semi-hard cheese typically made from the milk of goats, sheep, or cows. It's known for its tangy taste and firm, chewy texture.",
//            image: UIImage(named: "Halomi Salad"),
//            ingredients: [
//                Ingredient(name: "Plasamic", measurement: "🥄 Spoon", quantity: "1")
//            ]
//        )
//
//    RecipeCardView(recipe: recipe)
//}
