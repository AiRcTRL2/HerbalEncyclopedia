//
//  RecipeModelTestCase.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import XCTest

@testable import Herbal_Encyclopedia
class RecipeModelTestCase: XCTestCase {
    
    var recipeData: RecipesCategoriesContainerModel!

    override func setUpWithError() throws {
        super.setUp()
        recipeData = RecipesCategoriesContainerModel.readJson()
    }

    override func tearDownWithError() throws {
        super.tearDown()
        recipeData = nil
    }

    func testPrintRecipeCategoriesModel() throws {
        print()
        print()
        print("----------------------- RECIPE CATEGORIES -----------------------")
        print()
        for category in recipeData.data {
            print("----------------------- Category \(category.name) -----------------------")
            for recipe in category.recipes {
                print("----------------------- Recipe -----------------------")
                print(recipe)
                print()
            }
            print()
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
