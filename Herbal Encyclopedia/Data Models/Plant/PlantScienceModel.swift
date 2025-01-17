//
//  PlantScienceModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

/// Contains information relating to the scientific makeup of the plant
struct PlantScienceModel: Codable {
    let keyConstituents: [String]
    let volatileOils: [String]
}
