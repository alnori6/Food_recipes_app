//
//  RecipeEdit_page.swift
//  Food_recipes
//
//  Created by Noori on 29/10/2024.
//

import SwiftUI

struct RecipeEdit_page: View {
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view

    let recipe: Recipe // Accepts a Recipe object
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
            
                // MARK: - Recipe Image
                if let image = recipe.image {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width, height: 181)
                        .clipped()
                }
                
                // Recipe Description
                Text(recipe.description)
                    .font(.system(size: 12))
                    .padding(.horizontal)
                    .foregroundColor(Color("discribtionColor"))
                    .padding(.top, 8)
                
                // MARK: - Ingredients Section
                Text("Ingredient")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 24)
                    .padding(.horizontal)
                
                ForEach(recipe.ingredients, id: \.id) { ingredient in
                    HStack {
                        Text(ingredient.quantity)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("AccentColor"))
                        
                        Text(ingredient.name)
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(Color("AccentColor"))
                        
                        Spacer()
                        
                        HStack {
//                            Image(systemName: "fork.knife")
//                                .font(.system(size: 14))
                            Text(ingredient.measurement)
                                .font(.system(size: 16))
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color("AccentColor"))
                        .cornerRadius(8)
                        .foregroundColor(.white)
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 4)
                    .background(Color("boxes"))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
                
                Spacer()
                
                //MARK: - Delete Button
                Button(action: {
                    // Delete recipe action
                    print("Delete Recipe tapped")
                }) {
                    Text("Delete Recipe")
                        .foregroundColor(.red)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(8)
                        .padding(.horizontal)
                        .padding(.top, 20)
                }
            }
            // MARK: - naviagtion properties
            .scrollDismissesKeyboard(.immediately) // Keyboard will dismiss when scrolling starts
            .navigationTitle(recipe.title)
            .navigationBarBackButtonHidden(true) // Hide the default Back button
            .toolbar {
                // Custom Back Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        /// Custom Back action
                        presentationMode.wrappedValue.dismiss()
//                        recipeVM.resetInputFields_1()
                        
                    }) {
                        HStack {
                            Image(systemName: "chevron.left")
                                .font(.system(size: 17))
                            Text("Back")
                            
                        } // hstack end
                        .foregroundColor(Color("AccentColor"))
                    }
                } //toolbar item 1 end
                
                
                // Save Button
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
//                        recipeVM.addRecipe()
                    }) {
                        Text("Edit")
                            .foregroundColor(Color("AccentColor"))
                    }
                }//toolbar item 2 end
            } // end of the toolbar
            
            
        }
    }
}


#Preview {
    RecipeEdit_page(recipe: Recipe(title: "Halomi Salad", description: "A delicious salad with halomi cheese.", image: UIImage(named: "sampleImage"), ingredients: [
        Ingredient(name: "Plasamic", measurement: "Spoon", quantity: "1")
    ]))
}
