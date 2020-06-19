//
//  DescriptorViewModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 05/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

private enum PlantSpecficExplanations {
    static let bodilyEffects = "Bodily effects"
    static let preparation = "Preparation"
}

struct DescriptorViewModel {
    var pageTitle: String
    /// The json file to open with the desired descriptions.
    var jsonFileIdentifier: String?
    var descriptorTitles: [String]
    
    // sets the size of the tableview data source once explanations have been parsed
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

    /// This list is responsible for the amalgamation of both the titles and explanations lists in the most efficient manner known.
    var tableViewDataSource: [String]?
    
    /**
     Attempts to parse explanations from the json document reflecting the requested explanation titles. Will also attempt to parse plant specific explanations for the same title, amalgamating these two values in separate paragraphs.
     */
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
            // get plant specific additions for this page title
            let plantSpecificAdditions: [String:String]? = parsePlantSpecificExplanationForPageTitle(pageTitle: self.pageTitle)
            // parse explanations for titles required by the view controller (descriptions requested)
            for title in descriptorTitles {
                if var explanation = dictUnwrapped[title] {
                    // check if the plant also has a plant specific explanation (rather than only generic) for this page title
                    if let plantSpecificExplanation = plantSpecificAdditions?[title]  {
                        explanation = "\(explanation) \n\n\(plantSpecificExplanation)"
                    }
                    tempDict.append(explanation)
                } else {
                    tempDict.append("Oops. We couldn't find an explanation for \"\(title).\" It would be really helpful if you contacted me via the app and let me know what's missing so I can work on fixing that as soon as possible!")
                }
            }

            // set the struct's explanations for use by the view
            self.descriptorExplanations = tempDict
        }
    }
    
    /**
     This function attempts to fetch the plant specific explanation dictionary for the required plant section. It determines the correct plant section by maging the set view controller's title against the PlantSpecificExplanations enum.
     
     - Parameters:
        - pageTitle: String representation of the view controller's set page title
     
     - Returns:
        - A dictionary of title: explanation for the plant section that has a plant specific explanation, if one is found.
     */
    func parsePlantSpecificExplanationForPageTitle(pageTitle: String) -> [String:String]? {
        switch pageTitle {
        case PlantSpecficExplanations.bodilyEffects:
            return describingPlant?.bodilyEffects.plantSpecific
        case PlantSpecficExplanations.preparation:
            return describingPlant?.preparations.plantSpecific
        default:
            return nil
        }
    }
}
