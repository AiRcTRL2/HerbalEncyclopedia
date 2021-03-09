//
//  PlantSpotlightItem.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 09/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

/// A data container for each row of the plant currently highlighted
struct PlantSpotlightItem {
    let title: String
    let text: [String]
    let isExpansible: Bool
}
