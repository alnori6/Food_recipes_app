//
//  ContentView.swift
//  Food_recipes
//
//  Created by Noori on 17/10/2024.
//

import SwiftUI


// Modifier to set custom UINavigationBar background color
//struct NavigationBarModifier: ViewModifier {
//    
//    var backgroundColor: UIColor?
//    
//    init(backgroundColor: UIColor?) {
//        self.backgroundColor = backgroundColor
//        
//        // Create a new UINavigationBarAppearance instance
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground() // Make the background opaque
//        appearance.backgroundColor = backgroundColor // Set the background color
//        
//        // Customize title appearance (optional)
////        appearance.titleTextAttributes = [.foregroundColor: UIColor.white] // Title color
////        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white] // Large title color
//        
//        // Apply appearance for both standard and scrollEdge appearances
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//    }
//    
//    func body(content: Content) -> some View {
//        content
//    }
//}



struct hoome_page: View {
    var body: some View {
        
        NavigationView {
            ScrollView(.vertical){
                VStack {
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
                }
                .navigationTitle("Food Recipes")
                
                .navigationBarItems(trailing:
                    NavigationLink(destination: newRecipe_page()) {
                    Image(systemName: "plus")
                        .font(.system(size: 17))
                }
                )
                
                .modifier(NavigationBarModifier(backgroundColor: UIColor(named: "nav_background")))
            }
        }
    }
}



#Preview {
    hoome_page()
}


//here
