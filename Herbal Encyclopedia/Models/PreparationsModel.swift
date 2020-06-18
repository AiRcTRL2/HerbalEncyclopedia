//
//  PreparationsModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation

struct PreparationsModel: Codable {
    let methodsOfPreparation: [String]
    let plantSpecific: [String: String]
}
