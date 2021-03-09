//
//  Plant.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftyJSON
import Foundation

/// Responsible for parsing a list of Plant objects from json
struct PlantContainer: Codable {
    var data: [Plant]
}


/// Root model containing sub-models of plant information collected into logical segments
struct Plant: Codable {
    var id: Int
    let localImageName: String
    let plantInfo: PlantInfoModel
    let growthInfo: PlantGrowthInfoModel
    let uses: PlantUsesModel
    let science: PlantScienceModel
    let effects: PlantBodilyEffectsModel
    let preparations: PlantPreparationsModel
    let plantAddsDescriptionFor: [String: String]
}

extension Plant {
    /// Formulates a tableView data source from the Plant with information desired in the PlantView. All changes to what data is presented there should be made here.
    /// - Returns: A tableView datasource of type PlantSpotlightItem
    func makeTableViewRepresentable() -> [PlantSpotlightItem] {
            // reset list as this is a reused view controller
        let tableViewRepresentable: [PlantSpotlightItem] = [
            PlantSpotlightItem(title: "Latin name", text: [self.plantInfo.latinName], isExpansible: false),
            PlantSpotlightItem(title: "Alias", text: [self.plantInfo.alias], isExpansible: false),
            PlantSpotlightItem(title: "Plant species", text: [self.plantInfo.plantFamily], isExpansible: true),
            PlantSpotlightItem(title: "Native to", text: self.plantInfo.nativeTo, isExpansible: true),
            PlantSpotlightItem(title: "Growth Height", text: [self.growthInfo.height], isExpansible: false),
            PlantSpotlightItem(title: "Grows in", text: [self.growthInfo.growsIn], isExpansible: true),
            PlantSpotlightItem(title: "Primary use", text: [self.uses.primaryUse], isExpansible: true),
            PlantSpotlightItem(title: "Secondary use", text: [self.uses.secondaryUse], isExpansible: true),
            PlantSpotlightItem(title: "Tertiary use", text: [self.uses.tertiaryUse], isExpansible: true),
            PlantSpotlightItem(title: "Other uses", text: self.uses.otherUses, isExpansible: true),
            PlantSpotlightItem(title: "Active constituents", text: self.science.keyConstituents, isExpansible: true),
            PlantSpotlightItem(title: "Volatile oils", text: self.science.volatileOils, isExpansible: true),
            PlantSpotlightItem(title: "Bodily effects", text: self.effects.keyActions, isExpansible: true),
            PlantSpotlightItem(title: "Preparation", text: self.preparations.methodsOfPreparation, isExpansible: true)
        ]
        
        return tableViewRepresentable
    }
    
    
    /// For debugging the plant, this function prints out a string representation of the object.
    func printPlant() {
        print(   """
                      Id: \(self.id)\n
                      Name: \(self.plantInfo.name)\n
                      Latin Name: \(self.plantInfo.latinName)\n
                      Native To: \(self.plantInfo.nativeTo)\n
                      Growth Height: \(self.growthInfo.height)\n
                      Life Cycle: \(self.growthInfo.lifeCycle)\n
                      Primary Use: \(self.uses.primaryUse)\n
                      Secondary Use: \(self.uses.secondaryUse)\n
                      Tertiary Use: \(self.uses.tertiaryUse)\n
                      Other Uses: \(self.uses.otherUses)\n
                      Grows in: \(self.growthInfo.growsIn)\n
                      Key Constituents: \(self.science.keyConstituents)\n
                      Volatile oils: \(self.science.volatileOils)
                      Key Actions: \(self.effects.keyActions)\n
                      Uses Descriptions: \(self.uses.usesDescriptions)\n
                      Preparations: \(self.preparations)\n
                      Local Image Name: \(self.localImageName)\n
                      Warnings: \(self.plantInfo.warnings)
                   """
        )
    }

}
