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
    var descriptorModel: DescriptorViewModel!
    
    override func setUpWithError() throws {
        super.setUp()
        descriptorModel = DescriptorViewModel(pageTitle: "test", jsonFileIdentifier: "body_effects", descriptorTitles: ["Antipasmodic"], descriptorExplanations: nil)
    }

    override func tearDownWithError() throws {
        super.tearDown()
        descriptorModel = nil
    }

    func testExample() throws {
        descriptorModel.parseExplanationsFromTitles()
        print(descriptorModel.descriptorExplanations as Any)
        XCTAssert(!descriptorModel.descriptorExplanations!.isEmpty)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
