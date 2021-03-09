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
    var networkRequest: Request!
    var plants: [Plant]?

    override func setUpWithError() throws {
        networkRequest = Request()
        networkRequest.configure(requestType: .file, urlOrFileName: "herbs")
    }

    override func tearDownWithError() throws {
        networkRequest = nil
        plants = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
