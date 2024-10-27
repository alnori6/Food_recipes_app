//
//  Ingrediant_view.swift
//  Food_recipes
//
//  Created by Noori on 27/10/2024.
//

import SwiftUI

struct ingrediant_view: View {
    
    /// The ViewModel managing the photo picker and image selection.
    @ObservedObject var recipeVM: Recipe_ViewModel
    
    /// Binding to control visibility of the pop-up
//    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12){
            
            // MARK: - ingredient name
            Text("Ingrediant Name")
                .font(.system(size: 20))
                .bold()
            
            TextField("Ingrediant Name", text: .constant(""))
                .padding(.all, 10) // Padding inside the TextField
                .background(Color("boxes")) // Assuming boxes is a color from assets
                .cornerRadius(8) // Rounded corners for the TextField
                .font(.system(size: 14))
                .frame(width: 275, height: 39)
            
            // MARK: - Measurment
            Text("Measurment")
                .font(.system(size: 20))
                .bold()
            
            HStack(){
                Button(action: {
                    self.recipeVM.showAlert = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("boxes"))
                        .cornerRadius(8)
                }
                
                Button(action: {
                    self.recipeVM.showAlert = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 12))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color("boxes"))
                        .cornerRadius(8)
                }
            }// hstack end
            
        }
        .padding(.horizontal)
        
    }
}

#Preview {
    ingrediant_view(recipeVM: Recipe_ViewModel())
}
