//
//  recipe.swift
//  Food_recipes
//
//  Created by Noori on 24/10/2024.
//

import Foundation
import SwiftUI

struct Recipe: Identifiable {
//    let id: UUID = UUID()
    let id: UUID = .init()
    var title: String
    var description: String
    var image: UIImage?
    var ingredients: [Ingredient]
}

struct Ingredient: Identifiable {
//    let id: UUID = UUID()
    let id: UUID = .init()
    var name: String
    var measurment : String
    var quantity: String
}
