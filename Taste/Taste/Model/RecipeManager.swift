//
//  RecipeManager.swift
//  Taste
//
//  Created by amy on 2024-10-31.
//

import Foundation

protocol RecipeManagerDelegate {
    func didUpdateRecipes(_ recipeManager: RecipeManager, recipes: [RecipeModel])
    func didFailWithError(_ error: Error)
}

struct RecipeManager {
    
    var delegate: RecipeManagerDelegate?
    var session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchRecipes(with urlString: String) {
        
    }
    
    func parseJSON(_ recipeData: Data) -> [RecipeModel] {
        
    }
}
