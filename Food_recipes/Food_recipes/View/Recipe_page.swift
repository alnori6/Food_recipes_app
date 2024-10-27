//
//  Recipe_page.swift
//  Food_recipes
//
//  Created by Noori on 25/10/2024.
//

import SwiftUI
import PhotosUI

struct Recipe_page: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    /// The ViewModel managing the photo picker and image selection.
    @ObservedObject var recipeVM: Recipe_ViewModel
    

    var body: some View {
        
        ScrollView(.vertical) {
            
            PhotosPicker(selection: $recipeVM.photoPickerItem, matching: .images) {
                ZStack {
                    
                    if let recipeImage = recipeVM.recipeImage {
                        Image(uiImage: recipeImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 413, height: 181)
                            .clipped()
                    } else {
                        Rectangle()
                            .frame(width: 413, height: 181)
                            .foregroundColor(Color("boxes"))
                            .overlay(
                                Rectangle() // The shape for the dashed border
                                    .strokeBorder(style: StrokeStyle(lineWidth: 1, dash: [7, 5])) // Create dashed stroke
                                    .foregroundColor(Color("AccentColor")) // Color for the dashed border
                            )
                        
                        VStack {
                            Image(systemName: "photo.badge.plus")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 86, height: 71)
                                .foregroundColor(Color("AccentColor"))
                            
                            Text("Upload Photo")
                                .font(.system(size: 22))
                                .bold()
                                .foregroundColor(.black)
                                .padding(.top, -10)
                        } // vstack end 1
                        
                    } // else end
                } // zstack end 1
                
            }
            .padding(.top, 45)
            // validation
            .onAppear {
                recipeVM.checkPhotoLibraryPermission()
            }
            .alert(isPresented: $recipeVM.showAlert) {
                Alert(
                    title: Text("Photo Library Access Denied"),
                    message: Text("Please enable access to your photo library in Settings."),
                    primaryButton: .default(Text("Settings"), action: {
                        recipeVM.openSettings()
                    }),
                    secondaryButton: .cancel()
                )
            }
            
            
            // MARK: - Title TextField Section
            VStack(alignment: .leading, spacing: 12) {
                
                    Text("Title")
                    .font(.system(size: 24))
                    .bold()
//                        .padding(.bottom, 12)
                
                TextField("Title", text: $recipeVM.textTitle)
                    .padding(.all, 10) // Padding inside the TextField
                    .background(Color("boxes")) // Assuming boxes is a color from assets
                    .cornerRadius(8) // Rounded corners for the TextField
                    .font(.system(size: 24))
                    .frame(width: 367, height: 47)
                    
            }
            .padding(.top, 24) // Padding around the VStack to keep it away from the screen edges
            .padding(.horizontal)
            
            
            
            
            // MARK: - Description TextEditor Section
            VStack(alignment: .leading, spacing: 12) {
                
                Text("Description")
                    .font(.system(size: 24))
                    .bold()
                
                
                ZStack(alignment: .topLeading) {
                    
                    
                    TextEditor(text: $recipeVM.textDescription)
                        .padding(.all, 10) // Padding inside the TextField
                        .background(Color("boxes"))
                        .scrollContentBackground(.hidden) // this was the key to help solve the background color
                        .frame(width: 367, height: 130)
                        .cornerRadius(10) // Rounded corners for the TextField
                        .font(.system(size: 24))
                    
                    // Placeholder text
                    if recipeVM.textDescription.isEmpty { // Remove the '$' to get a Bool condition
                        Text("Description")
                            .foregroundColor(Color.gray)
                            .font(.system(size: 24))
                            .padding(.all, 18) // Padding to align with TextEditor's content
                    }
                    
                } // zstack end
                
                    
            } // vstack end
            .padding(.top, 24) // Padding around the VStack to keep it away from the screen edges
            .padding(.horizontal)
            
            
            
            HStack(){
                
                Text("Add Ingrediant")
                    .font(.system(size: 24))
                    .bold()
                    
                Spacer()
                
                NavigationLink(destination: newRecipe_page()) {
                Image(systemName: "plus")
                    .font(.system(size: 24))
                    .bold()
                    .foregroundColor(Color("AccentColor"))
                }
            }
            .padding(.top, 24) // Padding around the VStack to keep it away from the screen edges
            .padding(.horizontal)
            
        } // scroll view end
        
        
        // MARK: - naviagtion properties
        .navigationTitle("New Recipe")
        .navigationBarBackButtonHidden(true) // Hide the default Back button
        .toolbar {
            // Custom Back Button
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // Custom Back action
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
                    
                    // Save action
                }) {
                    Text("Save")
                        .foregroundColor(Color("AccentColor"))
                }
            }//toolbar item 2 end
        }
        
    }
}

#Preview {
    Recipe_page(recipeVM: Recipe_ViewModel())
}



//here
