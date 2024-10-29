//
//  Food_recipesApp.swift
//  Food_recipes
//
//  Created by Noori on 17/10/2024.
//

import SwiftUI

@main
struct Food_recipesApp: App {
    @StateObject private var recipeVM = Recipe_ViewModel()
    
    var body: some Scene {
        WindowGroup {
            home_page(recipeVM: Recipe_ViewModel())
                .accentColor(Color("AccentColor"))
                .font(.system(size: 17, weight: .regular, design: .default))
                .environmentObject(recipeVM)
        }
    }
}



//here
