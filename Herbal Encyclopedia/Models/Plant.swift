//
//  Plant.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import SwiftyJSON
import Foundation

struct Plant: Codable {
    var id: Int
    let localImageName: String
    let plantInformation: PlantInformationModel
    let growthInformation: GrowthInformationModel
    let plantUses: PlantUsesModel
    let plantScience: PlantScienceModel
    let bodilyEffects: BodilyEffectsModel
    let preparations: PreparationsModel
}

extension Plant {
    static func parse(json: JSON) -> Plant {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedPlantObj = try! decoder.decode(Plant.self, from: json.rawData())
        return decodedPlantObj
    }
    
    static func parseAllPlants(json: JSON) -> [Plant] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        var plants: [Plant] = []
        
        for (_, plant) in json["data"] {
            let decodedPlantObj = try! decoder.decode(Plant.self, from: plant.rawData())
            plants.append(decodedPlantObj)
        }
        
        return plants
    }
    
    static func readJSONFromFile(fileName: String) -> Data? {
        if let fileURL = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                // Getting data from JSON file using the file URL
                let data = try Data(contentsOf: fileURL, options: .mappedIfSafe)
                return data
            } catch {
                print("Failed to read json file")
            }
        }
        return nil
    }
    
    func printPlant() -> String {
        return """
                      Id: \(self.id)\n
                      Name: \(self.plantInformation.name)\n
                      Latin Name: \(self.plantInformation.latinName)\n
                      Native To: \(self.plantInformation.nativeTo)\n
                      Growth Height: \(self.growthInformation.growthHeight)\n
                      Life Cycle: \(self.growthInformation.lifeCycle)\n
                      Primary Use: \(self.plantUses.primaryUse)\n
                      Secondary Use: \(self.plantUses.secondaryUse)\n
                      Tertiary Use: \(self.plantUses.tertiaryUse)\n
                      Other Uses: \(self.plantUses.otherUses)\n
                      Grows in: \(self.plantInformation.growsIn)\n
                      Key Constituents: \(self.plantScience.keyConstituents)\n
                      Volatile oils: \(self.plantScience.volatileOils)
                      Key Actions: \(self.bodilyEffects.keyActions)\n
                      Uses Descriptions: \(self.plantUses.usesDescriptions)\n
                      Preparations: \(self.preparations)\n
                      Local Image Name: \(self.localImageName)\n
                      Warnings: \(self.plantInformation.warnings)
                   """
    }

}
