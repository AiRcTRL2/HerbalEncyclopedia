//
//  PlantUsesModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct PlantUsesModel: Codable {
    let primaryUse: String
    let secondaryUse: String
    let tertiaryUse: String
    let otherUses: [String]
    let usesDescriptions: [String]
}
