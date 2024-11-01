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
        
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(RecipeData.self, from: recipeData)
            let array = decodedData.recipes
            
            if array.count == 0 {
                let error = NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "The returned recipe list is empty."])
                delegate?.didFailWithError(error: error)
                return []
            }
            
            var recipes : [RecipeModel] = []
            
            for i in 0..<array.count {
                let recipe = RecipeModel(name: array[i].name,
                                         cuisine: array[i].cuisine,
                                         imageURL: array[i].photo_url_small,
                                         videoURL: array[i].youtube_url,
                                         sourceURL: array[i].source_url)
                recipes.append(recipe)
            }
            
            return recipes
            
        } catch {
            delegate?.didFailWithError(error: error)
            return []
        }
    }
}

extension RecipeManager {
    func fetchRecipes_local (_ filename: String) {
        guard let url = Bundle.main.url(forResource: filename, withExtension: "json") else {
            let error = NSError(domain: "", code: 100, userInfo: [NSLocalizedDescriptionKey: "Cannot find any JSON file."])
            delegate?.didFailWithError(error: error)
            return
        }
        do {
            let data = try Data(contentsOf: url)
            let results = parseJSON(data)
            delegate?.didUpdateRecipes(self, employees: results)
        } catch {
            delegate?.didFailWithError(error: error)
        }
    }
}
