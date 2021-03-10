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
    // MARK: Shared data properties
    private let sharedLookupDictionary: [String: String]
    
    // MARK: Shared networking objects
    private let plantRequest: PlantRequest
    
    init() {
        sharedLookupDictionary = AppContainer.buildLookupDictionary()
        
        let plantRequest: PlantRequest = PlantRequest()
        plantRequest.configure(requestType: .file, urlOrFileName: "herbs")
        self.plantRequest = plantRequest
    }

    /// Builds a plant view model
    func buildPlantViewModel() -> PlantViewModel {
        let data = plantRequest.fetchPlants()
        return PlantViewModel(plants: data ?? [])
    }
    
    func buildSearchViewModel() -> SearchViewModel {
        let data = plantRequest.fetchPlants()
        return SearchViewModel(plants: data ?? [])
    }
    
    func buildRecipesViewModel() -> RecipesViewModel {
        let request = RecipesRequest()
        let categories = request.fetchRecipes()
        
        return RecipesViewModel(categories: categories)
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
