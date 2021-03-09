//
//  CoreDataSpotlightPlant.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation
import CoreData

/// This represents the CoreData type to save to disk. Only one of these should ever be persisted. It should be updated during validation handled elsewhere.
class CoreDataSpotlightPlant: NSManagedObject {
    var savedPlant: Plant?
    var savedDate: Date = Date()
}
