///Users/siddhant/Documents/Github/RecipeApp/RecipeApp/ContentView.swift
//  ContentView.swift
//  RecipeApp
//
//  Created by Siddhant Gupta on 11/8/24.
//

import SwiftUI
import Kingfisher
struct ContentView: View {
    
    @StateObject var recipeViewModel = RecipeViewModel(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
    var body: some View {
        ZStack {
            Color(.systemGray6)
                .edgesIgnoringSafeArea(.all)
            
            NavigationStack {
                if (recipeViewModel.recipesList.keys.isEmpty) {
                    emptyRecipesView()
                }
                else{
                    List {
                        recipeListView(recipeViewModel: recipeViewModel)
                    }
                    .refreshable {          //Refresh Recipes only on User Input
                        try? await recipeViewModel.refreshRecipes()
                    }
                    .navigationTitle("Recipes")
                }
            }
        }
    }
}

//Main Recipe List - When there are recipes to show
struct recipeListView: View {
    @ObservedObject var recipeViewModel: RecipeViewModel
    var body: some View {
        ForEach(Array(recipeViewModel.recipesList.keys).sorted(), id: \.self) { key in
            Section(header: Text(key)) {
                let recipeArray = recipeViewModel.recipesList[key]
                ForEach (recipeArray ?? []) { recipe in
                    recipeCardView(recipe: recipe)
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                .listRowSeparator(.hidden)
                .listRowBackground(Color.clear)
                }
            .font(.headline)
            .fontWeight(.bold)
            }
        }
}
struct recipeCardView: View {
    let recipe: Recipe
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Recipe Image
            recipeImageView(recipe: recipe)
            
            // Recipe Name and Cuisine
            Text(recipe.name)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            Divider()
            
            // Links Section
            actionsView(recipe: recipe)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 5)
        .padding(.vertical)
    }
}
//View for the "View Recipe" and "Watch on Youtube" Button Actions
struct actionsView : View {
    let recipe : Recipe
    var body: some View {
        HStack {
            if let sourceURL = recipe.sourceURL, let url = URL(string: sourceURL) {
                Link("View Recipe", destination: url)
                    .font(.subheadline)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            if let youtubeURL = recipe.youtubeURL, let url = URL(string: youtubeURL) {
                Link("Watch on YouTube", destination: url)
                    .font(.subheadline)
                    .foregroundColor(.red)
            }
        }
        .padding(.top)
    }
}

//Recipe Image View
struct recipeImageView: View {
    let recipe: Recipe
    var body: some View {
        KFImage(URL(string: recipe.photoURLLarge))     //Kingfisher library for cacheing
            .placeholder({
                ProgressView()
            })
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .clipped()
            .cornerRadius(12)
            .shadow(radius: 4)
    }
}

//No Recipes To show
struct emptyRecipesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "leaf.arrow.triangle.circlepath")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.red)
            
            Text("No Recipes Available")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
            
            Text("Try refreshing to see new recipes!")
                .font(.subheadline)
                .foregroundColor(.black)
                .padding(.horizontal, 20)
                .multilineTextAlignment(.center)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 10)
        .padding(.horizontal)
    }
}
#Preview {
    ContentView()
}


