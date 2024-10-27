//
//  newRecipe_page.swift
//  Food_recipes
//
//  Created by Noori on 20/10/2024.
//

import SwiftUI
import PhotosUI
import UIKit

struct newRecipe_page: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing the view
    
    @State private var recipeImage: UIImage?
    @State private var photoPickerItem: PhotosPickerItem?
    
    @State private var showAlert = false // State to show permission alert
    @State private var deniedAccess = false // State to track if permission was denied
        
    @State var textTitle: String = ""
    @State var textDescription: String = ""
    
    var body: some View {
            ScrollView(.vertical) {
                
                // MARK: - Photo Picker Section
                PhotosPicker(selection: $photoPickerItem, matching: .images) {
                    ZStack {
                        if let recipeImage = recipeImage {
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
                .onChange(of: photoPickerItem) {
                    Task {
                        if let data = try? await photoPickerItem?.loadTransferable(type: Data.self),
                           let uiImage = UIImage(data: data) {
                            recipeImage = uiImage
                        }
                    }
                }
                // validation
                .onAppear {
                    checkPhotoLibraryPermission()
                }
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("Photo Library Access Denied"),
                        message: Text("Please enable access to your photo library in Settings."),
                        primaryButton: .default(Text("Settings"), action: {
                            openSettings()
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
                    
                    TextField("Title", text: $textTitle)
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
                        // Placeholder text
                        if textDescription.isEmpty {
                            Text("Description")
//                                .foregroundColor(Color.lightGray)
                                .padding(.all, 15) // Padding to align with TextEditor's content
                        }
                        
                        TextEditor(text: $textDescription)
                            .padding(.all, 10) // Padding inside the TextField
                            .background(Color("boxes"))
                            .scrollContentBackground(.hidden) // this was the key to help solve the background color
                            .frame(width: 367, height: 130)
                            .cornerRadius(10) // Rounded corners for the TextField
                            .font(.system(size: 24))
                    }
                    
                        
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
                
                
            } // ScrollView end
            .navigationTitle("New Recipe")
            .navigationBarItems(
                leading: Button(action: {
                    presentationMode.wrappedValue.dismiss() // Back action
                }) {
                    Text("Back")
                        .foregroundColor(Color("AccentColor")) // Adjust color as needed
                },
                trailing: Button(action: {
                    // Save action
                }) {
                    Text("Save")
                        .foregroundColor(Color("AccentColor"))
                }
            )
        
    }
    
    // Function to check photo library permissions
    private func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        if status == .denied || status == .restricted {
            showAlert = true
        }
    }
    
    // Function to open app settings
    private func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
} // Struct end

#Preview {
    newRecipe_page()
}



//here
