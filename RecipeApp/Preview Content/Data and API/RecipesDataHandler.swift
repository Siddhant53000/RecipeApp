//
//  RecipesDataHandler.swift
//  RecipeApp
//
//  Created by Siddhant Gupta on 11/10/24.
//

import Foundation
class RecipesDataHandler {
    //Get Recipes from Server
    func fetchRecipes(fromURLString urlString: String) async throws -> [String : [Recipe]] {
        do {
            let url = urlString
            let data = try await APIHelper().fetchData(from: url)
            return handleData(data: data)
        } catch {
            return [:]
        }
    }
    
    //Converting simple array of recipes to Dictonary with Cuisine as Key
    func handleData (data: Data) -> [String : [Recipe]] {
        let decoder = JSONDecoder()
        do {
            let recipes = try decoder.decode(RecipesList.self, from: data)
            var sortedRecipeData: [String : [Recipe]] = [:]
            for recipe in recipes.recipes {
                sortedRecipeData[recipe.cuisine, default: []].append(recipe)
            }
            return sortedRecipeData
        } catch {
            return [:]
        }
    }
}
