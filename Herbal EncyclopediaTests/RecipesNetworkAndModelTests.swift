//
//  RecipesNetworkAndModelTests.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 10/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import XCTest
@testable import Herbal_Encyclopedia

class RecipesNetworkAndModelTests: XCTestCase {
    var request: RecipesRequest!
    var recipeCategories: [RecipeCategoryModel]?

    override func setUpWithError() throws {
        request = RecipesRequest()
    }

    override func tearDownWithError() throws {
        request = nil
        recipeCategories = nil
    }

    func testFetch() throws {
        recipeCategories = request.fetchRecipes()
        XCTAssert(recipeCategories?.isEmpty == false)
    }

}
