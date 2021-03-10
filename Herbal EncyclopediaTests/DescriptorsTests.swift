//
//  DescriptorsTests.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 05/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import XCTest

@testable import Herbal_Encyclopedia
class DescriptorsTests: XCTestCase {
    var descriptorModel: DefinitionsViewModel!
    var plant: Plant?
    
    override func setUpWithError() throws {
        super.setUp()
        let networkRequest: PlantRequest = PlantRequest()
        networkRequest.configure(requestType: .file, urlOrFileName: "herbs")
        
        let plants = networkRequest.fetchPlants()?.filter { $0.id == 1}
        plant = plants?.first
        
        guard let plant = plant else {
            return
        }
        
        descriptorModel = AppDelegate.appContainer.buildDescriptorViewModel()
        descriptorModel.configure(pageTitle: "test", definitionHeadings: ["Antipasmodic"], describedPlant: plant)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        descriptorModel = nil
        plant = nil
    }

    func testDefinitionFound() throws {
        XCTAssert(descriptorModel.tableViewDataSource.first?.description == "An antipasmodic is an agent which helps to reduce muscle spasms.")
    }

}
