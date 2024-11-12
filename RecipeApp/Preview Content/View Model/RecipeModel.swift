//
//  RecipeModel.swift
//  RecipeApp
//
//  Created by Siddhant Gupta on 11/8/24.
//

import Foundation

// MARK: - Welcome
struct RecipesList: Codable {
    let recipes: [Recipe]
}

// MARK: - Recipe

struct Recipe: Identifiable, Codable {
    var id = UUID() // Default ObjectIdentifier value
    
    let cuisine, name: String
    let photoURLLarge, photoURLSmall: String
    let sourceURL: String?
    let uuid: String
    let youtubeURL: String?

    enum CodingKeys: String, CodingKey {
        case cuisine, name
        case photoURLLarge = "photo_url_large"
        case photoURLSmall = "photo_url_small"
        case sourceURL = "source_url"
        case uuid, youtubeURL = "youtube_url"
        // Exclude 'id' from Codable
    }
}
