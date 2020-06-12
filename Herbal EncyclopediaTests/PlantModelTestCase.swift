//
//  PlantModelTestCase.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 10/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import Herbal_Encyclopedia
class PlantModelTestCase: XCTestCase {
    
    var plantJson: Data!
    var plantJsonSerialized: JSON!
    var plant: Plant!
    
    override func setUpWithError() throws {
        super.setUp()
        
        // read json file
        plantJson = Plant.readJSONFromFile(fileName: "herbs")
        
        // serialize json file
        plantJsonSerialized = try JSON(data: plantJson)
        
        plant = Plant.parse(json: plantJsonSerialized["data"][0])
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
        plant = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testParsedJsonFile() {
        print(String(decoding: plantJson, as: UTF8.self))
        XCTAssert(plantJson != nil)
    }
    
    func testDidSerialize() {
        print(plantJsonSerialized["data"][0])
        XCTAssert(plantJsonSerialized != nil)
    }

    func testPlantExists() {
        print(plant as Any)
        XCTAssertTrue (plant != nil)
    }
    
    func testParseAllPlants() {
        let plants = Plant.parseAllPlants(json: plantJsonSerialized)
        print(plants)
        XCTAssert(!plants.isEmpty)
    }
    
    func testPlantSubModels() {
        let plantInformation = plant.plantInformation
        let growthInformation = plant.growthInformation
        let plantUses = plant.plantUses
        let plantScience = plant.plantScience
        let bodilyEffects = plant.bodilyEffects
        let preparations = plant.preparations
        
        print(plantInformation, growthInformation, plantUses, plantScience, bodilyEffects, preparations)
    }
    
    func testPrintPlant() {
        let plantPrinted: String = plant.printPlant()
        print(plantPrinted)
        XCTAssert(!plantPrinted.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
