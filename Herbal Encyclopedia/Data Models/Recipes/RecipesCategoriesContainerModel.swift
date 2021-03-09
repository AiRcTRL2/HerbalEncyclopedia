//
//  RecipesContainerModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct RecipesCategoriesContainerModel: Codable {
    let data: [RecipeCategoryModel]
    
    /// Returns an object of type RecipesCategoriesContainerModel, containing recipe categories which contains recipe models.
    static func readJson() -> RecipesCategoriesContainerModel? {
        if let path = Bundle.main.url(forResource: "recipes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                return self.decodeData(data: data)
            } catch {
                print(error)
            }
        }
        
        return nil
    }
    
    /// Use readJson (decodeData only used externally for testing purposes)
    static func decodeData(data: Data) -> RecipesCategoriesContainerModel? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let recipesCategoryObject = try decoder.decode(RecipesCategoriesContainerModel.self, from: data)
            return recipesCategoryObject
        } catch {
            print(error)
        }
        
        return nil
    }
}
