//
//  recipe.swift
//  Food_recipes
//
//  Created by Noori on 24/10/2024.
//

import Foundation
import SwiftUI


/// Model representing a Recipe.
struct Recipe: Identifiable {
    /// Unique identifier for the recipe.
    let id: UUID
    /// Title of the recipe.
    var title: String
    /// Description of the recipe.
    var description: String
    /// Image associated with the recipe.
    var image: UIImage?
    /// List of ingredients for the recipe.
    var ingredients: [Ingredient]
    
    /// Initializer for creating a new Recipe.
    /// - Parameters:
    ///   - id: The unique identifier (default is a new UUID).
    ///   - title: The title of the recipe.
    ///   - description: The description of the recipe.
    ///   - image: An optional image for the recipe.
    ///   - ingredients: An array of `Ingredient` objects.
    init(id: UUID = UUID(), title: String, description: String, image: UIImage? = nil, ingredients: [Ingredient] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.image = image
        self.ingredients = ingredients
    }
}




/// Model representing an Ingredient.
struct Ingredient: Identifiable {
    /// Unique identifier for the ingredient.
    let id: UUID
    /// Name of the ingredient.
    var name: String
    
    /// Mesurment
    var measurement: String
    
    /// Quantity of the ingredient.
    var quantity: String
    
    /// Initializer for creating a new Ingredient.
    /// - Parameters:
    ///   - id: The unique identifier (default is a new UUID).
    ///   - name: The name of the ingredient.
    ///   - quantity: The quantity of the ingredient.
    init(id: UUID = UUID(), name: String, measurement: String, quantity: String) {
        self.id = id
        self.name = name
        self.measurement = measurement
        self.quantity = quantity
    }
}



//here
