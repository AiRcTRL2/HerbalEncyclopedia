//
//  PlantNetworkRequestTests.swift
//  Herbal EncyclopediaTests
//
//  Created by Karim Elgendy on 09/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import XCTest
@testable import Herbal_Encyclopedia

class PlantNetworkRequestTests: XCTestCase {
    var request: PlantRequest!
    var plants: [Plant]?

    override func setUpWithError() throws {
        request = PlantRequest()
        request.configure(requestType: .file, urlOrFileName: "herbs")
        plants = request.fetchPlants()
    }

    override func tearDownWithError() throws {
        request = nil
        plants = nil
    }

    func testDidReceivePlants() throws {
        XCTAssert(plants?.isEmpty == false)
    }

}
