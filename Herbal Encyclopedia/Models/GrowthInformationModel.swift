//
//  GrowthInformationModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON

struct GrowthInformationModel: Codable {
    let growthHeight: String
    let growsIn: String
    let foliageType: String
    let disease: [String]
    let pests: [String]
    let lifeCycle: String
}
