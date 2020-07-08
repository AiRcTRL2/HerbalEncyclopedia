//
//  PlantInformationModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON

struct PlantInformationModel: Codable {
    let name: String
    let alias: String
    let latinName: String
    let plantFamily: String
    let nativeTo: [String]
    let warnings: [String]
}

extension PlantInformationModel {
    static func parse(json: JSON) -> PlantInformationModel {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decodedPlantObj = try! decoder.decode(PlantInformationModel.self, from: json.rawData())
        return decodedPlantObj
    }
}
