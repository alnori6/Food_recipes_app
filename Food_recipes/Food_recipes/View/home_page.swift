//
//  home_page.swift
//  Food_recipes
//
//  Created by Noori on 25/10/2024.
//

import SwiftUI
import Combine

struct home_page: View {
    /// The ViewModel managing the recipes and photo picker
    @ObservedObject var recipeVM: Recipe_ViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer().frame(height: 22)
                    
                    // Check if there are no recipes and display a placeholder view
                    if recipeVM.recipes.isEmpty {
                        VStack {
                            Image("logo")
                                .resizable()
                                .frame(width: 274, height: 274)
                            
                            Text("There's no recipe yet")
                                .font(.system(size: 34))
                                .fontWeight(.bold)
                                .padding(.top, 24)
                            
                            Text("Please add your recipes")
                                .foregroundColor(Color("guiding_text"))
                                .font(.system(size: 22))
                                .padding(.top, 24)
                            
                            Spacer()
                        }
                        .padding(.top, 50)
                    } else {
                        // Display list of recipes if there are any
                        VStack(alignment: .center, spacing: 10) {
                            ForEach(recipeVM.recipes) { recipe in
                                // Pass the selected recipe to RecipeDisplay_page
                                NavigationLink(destination: RecipeDisplay_page(recipe: recipe)) {
                                    RecipeCardView(recipe: recipe)
                                }
                            }
                        }
                    }
                    
                    Spacer()
                }
            }
            .navigationTitle("Food Recipes")
            .navigationBarItems(trailing:
                NavigationLink(destination: Recipe_page(recipeVM: recipeVM)) {
                    Image(systemName: "plus")
                        .font(.system(size: 17))
                        .foregroundColor(Color("AccentColor"))
                }
            )
            .modifier(NavigationBarModifier(backgroundColor: UIColor(named: "nav_background")))
        }
    }
}

#Preview {
    home_page(recipeVM: Recipe_ViewModel())
}
