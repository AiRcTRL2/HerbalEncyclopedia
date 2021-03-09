//
//  DescriptorViewModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 05/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

/// The descriptor view model is responsible for managing the interactions and data for a corresponding cell type.
/// It parses definitions from a look-up dictionaries for terms provided to it in the titlesNeedingDescriptions parameter and combines the results into a PlantDescriptorModel that serve a data source for a tableView.
class DefinitionsViewModel {
    /// The view title
    var pageTitle: String
    /// The list of strings requiring a definition
    var descriptorTitles: [String]
    /// The plant this view model is describing
    var plant: Plant
    /// A reference to the shared lookup dictionary for parsing definitions
    let lookupDictionary: [String: String]

    /// Holds data ready for use by a tableView
    var tableViewDataSource: [TitleAndDefinitionModel] = []
    
    init(pageTitle: String, titlesNeedingDescriptions: [String], lookupDictionary: [String: String], plant: Plant) {
        self.pageTitle = pageTitle
        self.descriptorTitles = titlesNeedingDescriptions
        self.lookupDictionary = lookupDictionary
        self.plant = plant
        self.parseExplanationsFromTitles()
    }
    
    
    /// Gets generic descriptions for the requested page title, then attempts to find a matching key in a plant specific explanation for the same term. This appends the result and provides a full description of the requested terms
    func parseExplanationsFromTitles() {
        // Add the title + explanation to the cellRow
        for title in descriptorTitles {
            var stringBuilder = ""
            
            // find a generic description for the term
            if let foundTitle = lookupDictionary[title] {
                stringBuilder.append(foundTitle)
            }
            
            // find a plant specific description for the term
            if let foundPlantSpecificTitle = plant.plantAddsDescriptionFor[title] {
                stringBuilder.isEmpty ?
                    stringBuilder.append(foundPlantSpecificTitle) : stringBuilder.append("\n\n\(foundPlantSpecificTitle)")
            }
            
            if stringBuilder.isEmpty {
                tableViewDataSource.append(
                    TitleAndDefinitionModel(
                        title: title,
                        description: "Oops. We couldn't find an explanation for \"\(title).\" It would be really helpful if you contacted me via the app and let me know what's missing so I can work on fixing that as soon as possible!")
                )
                  
            } else {
                tableViewDataSource.append(TitleAndDefinitionModel(title: title, description: stringBuilder))
            }
        }
    }
}
