//
//  RecipeCategory.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct RecipeCategoryModel: Codable {
    let name: String
    let categoryImage: String
    let recipes: [RecipeModel]
}
