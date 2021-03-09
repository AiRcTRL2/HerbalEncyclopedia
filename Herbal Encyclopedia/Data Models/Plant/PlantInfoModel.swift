//
//  PlantInformationModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Contains information relating to the plant & species
struct PlantInfoModel: Codable {
    let name: String
    let alias: String
    let latinName: String
    let plantFamily: String
    let nativeTo: [String]
    let warnings: [String]
}
