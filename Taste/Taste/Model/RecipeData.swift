//
//  RecipeData.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import Foundation

struct RecipeData: Codable {
    let recipes: [Recipe]
    
    struct Recipe: Codable {
        let cuisine: String
        let name: String
        let photo_url_large: String
        let photo_url_small: String
        let source_url: String
        let uuid: String
        let youtube_url: String
    }
}
