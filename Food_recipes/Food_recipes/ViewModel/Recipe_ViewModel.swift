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

    // Other properties...
    @Published var textTitle: String = ""
    @Published var textDescription: String = ""
    @Published var ingredients: [Ingredient] = []
    
    // Toggle to control the visibility of the pop-up
    @Published var showIngredientPopup: Bool = false

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
}
