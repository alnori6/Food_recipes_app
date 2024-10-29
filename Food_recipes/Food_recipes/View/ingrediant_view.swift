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
    @Binding var isPresented: Bool
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 8){
            
            // MARK: - ingredient name
            Text("Ingrediant Name")
                .font(.system(size: 20))
                .bold()
            
            TextField("Ingrediant Name", text: $recipeVM.ingredientName)
                .padding(.all, 10) // Padding inside the TextField
                .background(Color("boxes")) // Assuming boxes is a color from assets
                .cornerRadius(8) // Rounded corners for the TextField
                .font(.system(size: 14))
                .frame(width: 275, height: 39)
            
            
                .padding(.bottom, 20)
            // MARK: - Measurment
            Text("Measurment")
                .font(.system(size: 20))
                .bold()
            
            HStack(spacing: 12){
                Button(action: {
                    recipeVM.measurement = "🥄 Spoon"
                }) {
                    Text("🥄 Spoon")
                        .font(.system(size: 17))
                        .frame(width: 104, height: 31) // Set the desired size
                        .foregroundColor(.white)
                        .background(Color("AccentColor")) // Set the background color
                        .cornerRadius(8) // Rounded corners
                        
                }
                
                Button(action: {
                    recipeVM.measurement = "🥛 Cup"
                }) {
                    Text("🥛 Cup")
                        .font(.system(size: 17))
                        .frame(width: 104, height: 31) // Set the desired size
                        .foregroundColor(.white)
                        .background(Color("AccentColor")) // Set the background color
                        .cornerRadius(8) // Rounded corners
                }
                
            }// hstack end
            
            .padding(.bottom, 20)
            // MARK: - Serving
            
            Text("Serving")
                .font(.system(size: 20))
                .bold()
            
            ZStack(){
                
                HStack(spacing: 12){
                    
                    Rectangle()
                        .fill(Color.boxes)
                        .cornerRadius(4)
                        .frame(width: 145, height: 36)
                    
                    ZStack(){
                        Rectangle()
                            .fill(Color.accentColor)
                            .cornerRadius(4)
                            .frame(width: 145, height: 36)
                            .padding(.leading, -30)
                        
                        
                        Text(recipeVM.measurement)
                            .font(.system(size: 17))
                            .fontWeight(.medium)
                            .foregroundColor(.white)
                            .padding(.trailing, 36)
                    }// end zstack
                    
                } // end hstack
                
                // MARK: - Stepper-like UI for incrementing and decrementing quantity
                HStack(spacing: 10){
                    Button(action: {
                        if recipeVM.quantity > 1 {
                            recipeVM.quantity -= 1
                        }
                    }) {
                        Image(systemName: "minus.square")
                            .font(.title)
                            .foregroundColor(.accentColor)
                    }
                    
                    Text("\(recipeVM.quantity)")
                        .font(.title)
                    
                    Button(action: {
                        recipeVM.quantity += 1
                    }) {
                        Image(systemName: "plus.square")
                            .font(.title)
                            .foregroundColor(.accentColor)
                    }
                    
                } .padding(.trailing, 155)// hstack end
                
            } // zstack end
            
            
            
            .padding(.bottom, 37)
            // MARK: - Cancel and Add Buttons
           HStack {
               Button(action: {
                   // Cancel action
                   recipeVM.resetInputFields()
                   isPresented = false
               }) {
                   Text("Cancel")
                       .foregroundColor(.accentColor)
                       .font(.system(size: 20))
                       .padding()
                       .frame(width: 134, height: 36) // Set the desired size
                       .background(Color("boxes")) // Set the
                       .cornerRadius(5)
               }
               
               Button(action: {
                   // Add action
                   recipeVM.addIngredient()
                   isPresented = false
               }) {
                   Text("Add")
//                       .frame(maxWidth: .infinity)
                       .foregroundColor(.white)
                       .font(.system(size: 20))
                       .padding()
                       .frame(width: 134, height: 36) // Set the desired size
                       .background(Color("AccentColor")) // Set the
                       .cornerRadius(5)
               }
           }
            
            
        }
        .padding(.horizontal)
        .background(Color("popup_background"))
        // Inside Recipe_page.swift
        .alert(isPresented: $recipeVM.showAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text(recipeVM.alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        
    }
}


// MARK: - preview
#Preview {
    // Local State variable to simulate the 'isPresented' binding for the preview
    @Previewable @State var isPresented = true
    
    // Return the ingredient view for preview purposes
    return ingrediant_view(recipeVM: Recipe_ViewModel(), isPresented: $isPresented)
}


