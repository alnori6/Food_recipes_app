//
//  NavigationBarModifier.swift
//  Food_recipes
//
//  Created by Noori on 26/10/2024.
//

import SwiftUI

// Modifier to set custom UINavigationBar background color
struct NavigationBarModifier: ViewModifier {
    
    var backgroundColor: UIColor?
    
    init(backgroundColor: UIColor?) {
        self.backgroundColor = backgroundColor
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = backgroundColor
        
        // Optionally customize the title appearance
        // appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        // appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
    
    func body(content: Content) -> some View {
        content
    }
}
