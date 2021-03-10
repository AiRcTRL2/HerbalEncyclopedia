//
//  AppContainer.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation
import CoreData

/// The app container is responsbile for building the viewModels throughout the app. It should be propagated to viewControllers as needed. ViewControllers should only further propagate required methods or shared data from the app container
class AppContainer {
    private let sharedLookupDictionary: [String: String]
    
    init() {
        sharedLookupDictionary = AppContainer.buildLookupDictionary()
    }

    /// Builds a plant view model
    func buildPlantViewModel() -> PlantViewModel {
        let request: PlantRequest = PlantRequest()
        request.configure(requestType: .file, urlOrFileName: "herbs")
        
        let data = request.fetchPlants()
        
        let plantViewModel = PlantViewModel(plants: data ?? [])
        
        return plantViewModel
    }
    
    /// Builds a Descriptor view model, providing explanations for a list of titles
    func buildDescriptorViewModel() -> DefinitionsViewModel {
        DefinitionsViewModel(lookupDictionary: sharedLookupDictionary)
    }
    
    /// Prepares the app for dictionary lookups by combining different dictionaries into one
    /// - Returns: A single dictionary
    static func buildLookupDictionary() -> [String: String] {
        let request = DictionaryRequest()
        
        var dictionaries = [[String: String]]()
        // parse all dictionaries available
        for dictionaryFilename in LookupDictionaryFilenameEnums.allCases {
            let dictionary = request.fetchDictionary(url: dictionaryFilename.rawValue)
            
            guard dictionary != nil else {
                continue
            }
            
            dictionaries.append(dictionary!)
        }
        
        // flatten and return the dictionaries
        let flattenedDict = dictionaries.flatMap { $0 }
        
        return Dictionary(flattenedDict, uniquingKeysWith: { first, last in last })
    }
}
