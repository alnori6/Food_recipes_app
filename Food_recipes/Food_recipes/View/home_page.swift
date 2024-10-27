//
//  home_page.swift
//  Food_recipes
//
//  Created by Noori on 25/10/2024.
//

import SwiftUI

struct home_page: View {
    
    @EnvironmentObject var homeVM: home_ViewModel
    
    var body: some View {
        NavigationView {
            
//            if homeVM.isEmpty {
            
                ScrollView{
                    VStack{
                        
                        Spacer()
                            .frame(height: 79)
                        
                        // Fork and Knife Image (System Image or Custom)
                        Image("logo")
                            .resizable()
                            .frame(width: 274, height: 274)
                        
                        // Main Text
                        Text("There's no recipe yet")
                            .font(.system(size: 34))
                            .fontWeight(.bold)
                            .padding(.top, 24)
                        
                        // Sub Text
                        Text("Please add your recipes")
                            .foregroundColor(Color("guiding_text"))
                            .font(.system(size: 22))
                            .padding(.top, 24)
                        
                        Spacer()
                        
                    } // end vstack
                    
                    
                } // end scroll view
                .navigationTitle("Food Recipes")
                
                .navigationBarItems(trailing:
                    NavigationLink(destination: Recipe_page(recipeVM: Recipe_ViewModel())) {
                    Image(systemName: "plus")
                        .font(.system(size: 17))
                    }
                )
            
                
                .modifier(NavigationBarModifier(backgroundColor: UIColor(named: "nav_background")))
                
            }// end navigation view
            
//        } else {
//                // Display the list of recipes
//                List {
//                    ForEach(recipesVM.recipes) { recipe in
//                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
//                            Text(recipe.title)
//                        }
//                    }
//                    .onDelete(perform: recipesVM.deleteRecipe)
//                }
//                .navigationTitle("Food Recipes")
//                .navigationBarItems(trailing:
//                    NavigationLink(destination: NewRecipeView()) {
//                        Image(systemName: "plus")
//                            .font(.system(size: 17))
//                    }
//                )
//                .modifier(NavigationBarModifier(backgroundColor: UIColor(named: "nav_background")))
//            }
    } //end body view
}

#Preview {
    home_page()
}



//here
