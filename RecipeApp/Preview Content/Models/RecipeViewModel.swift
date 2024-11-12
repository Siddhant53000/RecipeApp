//
//  RecipeViewModel.swift
//  RecipeApp
//
//  Created by Siddhant Gupta on 11/8/24.
//

import Foundation

class RecipeViewModel : ObservableObject {
    @Published var recipesList: [String : [Recipe]] = [:]
    let recipesDataHandler: RecipesDataHandler = RecipesDataHandler()
    private let urlString: String
    
    @MainActor
    init (urlString: String) {
        self.urlString = urlString
        Task {
            try? await recipesList = recipesDataHandler.fetchRecipes(fromURLString: self.urlString)
        }
    }
    
    @MainActor
    func refreshRecipes() async throws {
        try? await recipesList = recipesDataHandler.fetchRecipes(fromURLString: self.urlString)
    }

}
