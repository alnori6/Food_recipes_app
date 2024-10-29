//
//  RecipeDisplay_page.swift
//  Food_recipes
//
//  Created by Noori on 29/10/2024.
//

import SwiftUI

struct RecipeDisplay_page: View {
    let recipe: Recipe // Accepts a specific recipe
    
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    @EnvironmentObject var recipeVM: Recipe_ViewModel // Access to the ViewModel
    
    @State private var showDeleteConfirmation = false // Controls the delete confirmation dialog
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                // MARK: - Recipe Image with Overlay
                if let image = recipe.image {
                    ZStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 430, height: 181)
                            .clipped()
                        
                        // Shading overlay at the bottom
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.0), Color.black.opacity(0.7)]),
                            startPoint: .center,
                            endPoint: .bottom
                        )
                        .frame(width: 430, height: 181)
                        .clipped()
                    }
                }
                
                // Recipe Description
                Text(recipe.description)
                    .font(.system(size: 12))
                    .padding(.horizontal)
                    .foregroundColor(Color("discribtionColor"))
                    .padding([.top, .leading], 8)
                
                // MARK: - Ingredients Section Header
                Text("Ingredients")
                    .font(.system(size: 24, weight: .bold))
                    .padding(.top, 24)
                    .padding(.horizontal)
                    .padding(.leading, 8)
                
                // Display Ingredients List
                VStack(alignment: .center, spacing: 10) {
                    ForEach(recipe.ingredients) { ingredient in
                        HStack {
                            Spacer()
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color("boxes"))
                                .frame(width: 380, height: 50)
                                .overlay(
                                    HStack(spacing: 10) {
                                        Text("\(ingredient.quantity)")
                                            .font(.system(size: 20))
                                            .bold()
                                            .foregroundColor(.accentColor)
                                        
                                        Text(ingredient.name)
                                            .font(.headline)
                                            .foregroundColor(.accentColor)
                                            .lineLimit(1)
                                            .padding(.leading, 5)
                                        
                                        Spacer()
                                        
                                        Text(ingredient.measurement)
                                            .padding(5)
                                            .background(Color.accentColor.opacity(0.7))
                                            .foregroundColor(.white)
                                            .cornerRadius(8)
                                    }
                                    .padding(.horizontal, 10)
                                )
                            Spacer()
                        } // end hstack
                    } // end foreach
                } // end vstack
                .padding(.horizontal)
                
                // MARK: - Delete Button
                
            }
        } // scroll view end
        Button(action: {
            showDeleteConfirmation = true
        }) {
            Text("Delete Recipe")
                .foregroundColor(.accentColor)
                .font(.system(size: 20))
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color("boxes"))
                .cornerRadius(8)
        }
        .padding(.horizontal)
        .padding(.bottom, 20)
            
        
        .navigationTitle(recipe.title) // Display recipe title
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // Custom Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Custom Back action
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 22))
                        Text("Back")
                            .font(.system(size: 17))
                    }
                    .foregroundColor(Color("AccentColor"))
                }
            }
            
            // Edit Button
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: Recipe_page(recipeVM: recipeVM, recipeToEdit: recipe)) {
                    Text("Edit")
                        .foregroundColor(Color("AccentColor"))
                        .font(.system(size: 17))
                }
            }
        }
        .confirmationDialog("Are you sure you want to delete this recipe?", isPresented: $showDeleteConfirmation, titleVisibility: .visible) {
            Button("Delete", role: .destructive) {
                deleteRecipe()
            }
            Button("Cancel", role: .cancel) {}
        }
    }
    
    // MARK: - Functions
    
    /// Deletes the current recipe from the ViewModel's list
    func deleteRecipe() {
        if let index = recipeVM.recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipeVM.recipes.remove(at: index)
            presentationMode.wrappedValue.dismiss() // Dismiss the view after deletion
        }
    }
}

#Preview {
    
    let recipeVM = Recipe_ViewModel()
     RecipeDisplay_page(recipe: recipeVM.recipes.first!)
        .environmentObject(recipeVM)
}


