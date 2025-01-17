//
//  DictionaryContainer.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

/// Model used for parsing JSON dictionaries
struct DictionaryContainer: Codable {
    let data: [String: String]
}
