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
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    let recipes = self.parseJSON(safeData)
                    self.delegate?.didUpdateRecipes(self, recipes: recipes)
                } else {
                    let error = NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "The request does not return any data."])
                    delegate?.didFailWithError(error: error)
                }
            }
            task.resume()
        } else {
            let error = NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "The URL is invalid."])
            delegate?.didFailWithError(error: error)
        }
    }
    
    func parseJSON(_ recipeData: Data) -> [RecipeModel] {
        
        
        
        return []
    }
}
