//
//  JSONFileNamesEnum.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

enum LookupDictionaryFilenameEnums: String, CaseIterable {
    case plantSpecies = "plant_species"
    case activeIngredients = "key_constituents"
    case bodyEffects = "body_effects"
    case volatileOils = "volatile_oils"
    case preparationMethods = "preparation_methods"
}
