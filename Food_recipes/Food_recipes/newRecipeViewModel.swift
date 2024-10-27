//
//  recipeViewModel.swift
//  Food_recipes
//
//  Created by Noori on 24/10/2024.
//



import Foundation
import SwiftUI
import PhotosUI
import Combine

//MARK: - Manages the list of recipes.

class newRecipeViewModel: ObservableObject {
    
    @Published var recipeImage: UIImage?
    @Published var photoPickerItem: PhotosPickerItem?
    @Published var showAlert = false
    @Published var deniedAccess = false
    
    
    @Published var recipes: [Recipe] = []
    @Published var Ingredients: [Ingredient] = []

    @Published var titleText: String = ""
    @Published var descriptionText: String = ""
    

//MARK: - addRecipe function
    
    func addRecipe(){
        let newRecipe: Recipe = Recipe(title: titleText, description: descriptionText, ingredients: Ingredients)
        
        self.Ingredients.removeAll()
        self.titleText = ""
        self.descriptionText = ""
        
        self.recipes.append(newRecipe)
//        showAddCakeSheet.toggle()
    }
    

}


//here
