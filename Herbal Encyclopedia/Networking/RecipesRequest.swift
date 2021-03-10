//
//  RecipesRequest.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 10/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

protocol RecipesRequestProtocol {
    func fetchRecipes() -> [RecipeCategoryModel]?
}

class RecipesRequest: Request, RecipesRequestProtocol {
    func fetchRecipes() -> [RecipeCategoryModel]? {
        configure(requestType: .file, urlOrFileName: "recipes")
        
        let data = request()
        
        guard data != nil, let recipesContainer: RecipesCategoriesContainerModel? = ModelParser.parseJson(data!) else {
            return nil
        }
        
        return recipesContainer?.data
    }
}
