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
    var recipeToEdit: Recipe? = nil // Add this parameter
    

    var body: some View {
        ZStack(){
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
                                    .foregroundColor(Color("textColor"))
                                    .padding(.top, -10)
                            } // vstack end 1
                            
                        } // else end
                    } // zstack end 1
                    
                }
                .onAppear {
                    recipeVM.checkPhotoLibraryPermission()
                }
                .padding(.top, 45)
                .onTapGesture {
                    recipeVM.requestPhotoLibraryPermission { granted in
                        if granted {
                            // Permission was granted; continue with photo picking
                        } else {
                            recipeVM.showAlert = true
                            recipeVM.alertMessage = "Please enable access to your photo library in Settings."
                        }
                    }
                }
                // MARK: - cam permission
                
                // validation
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
                
                
                //MARK: - Add ingredients
                    
                    HStack(){
                        
                        Text("Add Ingrediant")
                            .font(.system(size: 24))
                            .bold()
                        
                        Spacer()
                        
                        Button(action: {
                            recipeVM.showIngredientPopup = true
                            
                        }){
                            Image(systemName: "plus")
                                .font(.system(size: 24))
                                .bold()
                                .foregroundColor(Color("AccentColor"))
                        }
                        // MARK: - Present the pop-up
                        // Present the pop-up using a popover instead of a sheet
                        //                .popover(isPresented: $recipeVM.showIngredientPopup, arrowEdge: .bottom) {
                        //                    ingrediant_view(recipeVM: recipeVM, isPresented: $recipeVM.showIngredientPopup)
                        //                        .frame(width: 306, height: 382) // Set the size of the popover
                        //                        .presentationCompactAdaptation(.popover)
                        //                }
                        
                    } // end hstack
                    .padding(.top, 24) // Padding around the VStack to keep it away from the screen edges
                    .padding(.horizontal)
                    
                    
                //MARK: - List of ingredients
                
                // Display Ingredients List
                VStack(alignment: .center, spacing: 10) {
                    if !recipeVM.ingredients.isEmpty {
                        ForEach(recipeVM.ingredients) { ingredient in
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
                            }
                        }
                    } // end if
                } // end VStack
                
            } // scroll view end
            
            
            
            // MARK: - naviagtion properties
            .scrollDismissesKeyboard(.immediately) // Keyboard will dismiss when scrolling starts
            .navigationTitle("New Recipe")
            .navigationBarBackButtonHidden(true) // Hide the default Back button
            .toolbar {
                // Custom Back Button
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        /// Custom Back action
                        presentationMode.wrappedValue.dismiss()
                        recipeVM.resetInputFields_1()
                        
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
                        recipeVM.addRecipe()
                        presentationMode.wrappedValue.dismiss() 
                        
                    }) {
                        Text("Save")
                            .foregroundColor(Color("AccentColor"))
                            
                    }.disabled(recipeVM.textTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                               recipeVM.textDescription.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
                                     recipeVM.ingredients.isEmpty ||
                                     recipeVM.recipeImage == nil) // Disable if photo is required
                }//toolbar item 2 end
                
            } // end of the toolbar
            
            
            // MARK: - Present the pop-up
            
            // Overlay for displaying the pop-up view
            if recipeVM.showIngredientPopup {
                Color.black.opacity(0.9) // Dim background
                    .ignoresSafeArea()
                    .onTapGesture {
                        // Dismiss pop-up when tapping on the background
                        recipeVM.showIngredientPopup = false
                    }
                
                ingrediant_view(recipeVM: recipeVM, isPresented: $recipeVM.showIngredientPopup)
                    .frame(width: 306, height: 382)
                    .background(Color("popup_background"))
                    .cornerRadius(9)
                    .shadow(radius: 10)
                    .padding(.horizontal, 20)
            }
        }
        .animation(.easeInOut, value: recipeVM.showIngredientPopup) // Add animation
        
    }
}

#Preview {
    Recipe_page(recipeVM: Recipe_ViewModel())
}



