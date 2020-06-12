//
//  DescriptorViewModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 05/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct DescriptorViewModel {
    var pageTitle: String
    /**
     The json file to open with the desired descriptions.
     */
    var jsonFileIdentifier: String?
    var descriptorTitles: [String]
    var descriptorExplanations: [String]? {
        didSet {
            if descriptorTitles.count == 1 {
                if let descriptorExplanations = descriptorExplanations {
                    tableViewDataSource = [descriptorTitles[0], descriptorExplanations[0]]
                }
            } else {
                tableViewDataSource = (0 ... descriptorTitles.count*2-1).map { $0 % 2 == 0 ? descriptorTitles[$0/2] as String : (descriptorExplanations?[$0/2] ?? "") as String }
            }
        }
    }
    var describingPlant: Plant?
    /**
     This list is responsible for the amalgamation of both the titles and explanations lists in the most efficient manner known.
     */
    var tableViewDataSource: [String]?
    
    mutating func parseExplanationsFromTitles() {
        var dict: [String: String]?
        
        // check existence of path
        if let path = Bundle.main.path(forResource: self.jsonFileIdentifier, ofType: "json") {
            // attempt to parse data
            do {
                // read the data into virtual memory if safe
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                // serialize with json with leaf nodes as NSMutableString and map into dictionary
                let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? Dictionary<String, [String: String]>

                // set the data dict for parsing titles into explanations
                dict = json?["data"]

            } catch {
                print("Could not read json file", error)
            }
        }

        // check if dict values are available
        if let dictUnwrapped = dict {
            var tempDict: [String] = []
            // parse explanations for titles required by the view controller (descriptions requested)
            for title in descriptorTitles {
                if let explanation = dictUnwrapped[title] {
                    tempDict.append(explanation)
                }
            }

            // set the struct's explanations for use by the view
            self.descriptorExplanations = tempDict
        }
    }
}
