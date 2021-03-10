//
//  PlantModelTestCase.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 10/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import XCTest

@testable import Herbal_Encyclopedia
class PlantModelTestCase: XCTestCase {
    var plants: [Plant]?
    var firstPlant: Plant?
    
    override func setUpWithError() throws {
        super.setUp()
        
        let plantRequest = PlantRequest()
        plantRequest.configure(requestType: .file, urlOrFileName: "herbs")
        
        plants = plantRequest.fetchPlants()
        
        self.firstPlant = plants?.first
        
    }

    override func tearDownWithError() throws {
        super.tearDown()
        plants = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testPlantExists() {
        XCTAssertTrue (plants != nil)
    }
    
    func testParseAllPlants() {
        XCTAssert(plants?.isEmpty == false)
    }
    
    func testPrintPlant() {
        firstPlant?.printPlant()
        XCTAssert(true)
    }
}
