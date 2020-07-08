//
//  RecipesContainerModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct RecipesCategoriesModel: Codable {
    let data: [String: [RecipeModel]]
    
    static func readJson() -> RecipesCategoriesModel? {
        if let path = Bundle.main.url(forResource: "recipes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let recipesCategoryObject = try decoder.decode(RecipesCategoriesModel.self, from: data)
                return recipesCategoryObject
            } catch {
                print(error)
            }
        }
        
        return nil
    }
}
