//
//  Recipe_ViewModel.swift
//  Food_recipes
//
//  Created by Noori on 25/10/2024.
//

import SwiftUI
import PhotosUI
import Combine

/// ViewModel for handling the photo picker and image selection for a recipe.
class Recipe_ViewModel: ObservableObject {
    // MARK: - Published Properties

    /// The selected recipe image to be displayed.
    @Published var recipeImage: UIImage?

    /// The selected item from the Photos picker.
    @Published var photoPickerItem: PhotosPickerItem?

    /// Boolean to control the display of the alert when photo library access is denied.
    @Published var showAlert = false

    @Published var alertMessage = "" // Message to show in the alert
   

    // MARK: - Private Properties

    /// Set to store any Combine cancellables.
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Initializer

    init() {
        // Set up a Combine pipeline to handle changes to photoPickerItem.
        $photoPickerItem
            .compactMap { $0 } // Ignore nil values.
            .flatMap { item in
                // Load the image data asynchronously.
                Future<UIImage?, Never> { promise in
                    Task {
                        if let data = try? await item.loadTransferable(type: Data.self) {
                            let uiImage = UIImage(data: data)
                            promise(.success(uiImage)) // uiImage can be nil.
                        } else {
                            promise(.success(nil)) // No data; pass nil as the image.
                        }
                    }
                }
            }
            .receive(on: DispatchQueue.main)
            .assign(to: &$recipeImage)
    }

    // MARK: - Methods

    /// Checks the photo library permission status and updates showAlert if access is denied.
    func checkPhotoLibraryPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        if status == .denied || status == .restricted {
            showAlert = true
        }
    }

    /// Opens the app's settings in the Settings app to allow the user to change permissions.
    func openSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString),
           UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    
    
    
    func requestPhotoLibraryPermission(completion: @escaping (Bool) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { newStatus in
                DispatchQueue.main.async {
                    completion(newStatus == .authorized || newStatus == .limited)
                }
            }
        case .authorized, .limited:
            completion(true)
        case .denied, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }

    
    
    
    //MARK: - methods for the ingridents popup
    
    @Published var ingredients: [Ingredient] = []
    
    // Toggle to control the visibility of the pop-up
    @Published var showIngredientPopup: Bool = false
    
    // Temporary properties for the pop-up input fields
    @Published var ingredientName: String = ""
    @Published var measurement: String = "" // Default measurement
    @Published var quantity: Int = 1 // Default quantity value
    
//    if ( measurement == "Cup"){
//        
//    }
    
    
    
    /// Function to add a new ingredient to the list
    func addIngredient() {
        
        guard !ingredientName.isEmpty else {
            triggerAlert(message: "Please provide a name for the ingredient.")
                    return
                }
                
        guard !measurement.isEmpty else {
            triggerAlert(message: "Please select a measurement for the ingredient.")
            return
        }
        
        let newIngredient = Ingredient(
            name: ingredientName,
            measurement: measurement,
            quantity: "\(quantity)")
        
        ingredients.append(newIngredient)
        resetInputFields()
        showIngredientPopup = false // Close the pop-up
    }
    
    
    
    
    
    
    // MARK: -  the recipe function to add a new one
    
    // Other properties...
    @Published var textTitle: String = ""
    @Published var textDescription: String = ""
    
    // In your Recipe_ViewModel
//    @Published var recipes: [Recipe] = [] // Array to store all recipes
    @Published var recipes: [Recipe] = [
        Recipe(
            title: "Halomi Salad",
            description: "semi-hard cheese typically made from the milk of goats, sheep, or cows. It's known for its tangy taste and firm, chewy texture.",
            image: UIImage(named: "Halomi Salad"),
            ingredients: [
                Ingredient(name: "Plasamic", measurement: "🥄 Spoon", quantity: "1")
            ]
        )
    ]
    
    
    func addRecipe() {
        // Check if any required fields are empty
        guard !textTitle.isEmpty else {
            triggerAlert(message: "Please provide a title for the recipe.")
            return
        }
        
        guard !textDescription.isEmpty else {
            triggerAlert(message: "Please provide a description for the recipe.")
            return
        }
        
        guard !ingredients.isEmpty else {
            triggerAlert(message: "Please add at least one ingredient.")
            return
        }
        
        let newRecipe = Recipe(
            title: textTitle,
            description: textDescription,
            image: recipeImage,
            ingredients: ingredients) // Directly pass ingredients
        // Assuming you have an array of recipes to append to:
        recipes.append(newRecipe) // Append newRecipe to your list of recipes (uncomment if needed)
        
        resetInputFields_1()
        
//        showIngredientPopup = false // Close the pop-up
    }
    
    // MARK: - Alert Handling

        /// Sets the alert message and toggles the showAlert flag
        private func triggerAlert(message: String) {
            alertMessage = message // Set the message to display
            showAlert = true // Set showAlert to true to display the alert in the view
        }
    
    // MARK: - genral method to reset inputs
    
    /// Function to reset the input fields after adding or cancelling
    func resetInputFields_1() {
        recipeImage = nil
        textTitle = ""
        textDescription = ""
        ingredients.removeAll()
        
    }
    
    /// Function to reset the input fields after adding or cancelling
    func resetInputFields() {
        ingredientName = ""
        measurement = ""
        quantity = 1
    }
    
    
    
    // MARK: - Delete Recipes

    func deleteRecipe(recipe: Recipe) {
            if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                recipes.remove(at: index)
            }
        }

    
    
    
    
    
}




