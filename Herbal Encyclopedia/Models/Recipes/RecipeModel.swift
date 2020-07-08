//
//  RecipesModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct RecipeModel: Codable {
    let recipeName: String
    let recipeSteps: [String]
}
