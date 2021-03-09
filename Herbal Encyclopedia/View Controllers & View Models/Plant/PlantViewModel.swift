//
//  PlantViewModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

protocol PlantDidLoadDelegate: class {
    func plantLoadedSuccessfully()
}

class PlantViewModel {
    var plants: [Plant]
    var spotlightPlant: CoreDataSpotlightPlant?
    var tableViewRepresentable: [PlantSpotlightItem] = []
    
    weak var plantLoadedDelegate: PlantDidLoadDelegate?
    
    init(plants: [Plant]) {
        // TODO: load spotlight plant from core data, if available
        self.plants = plants
        
        updatePlant()
        tableViewRepresentable = spotlightPlant?.savedPlant?.makeTableViewRepresentable() ?? []
    }
    
    /// Indicates whether the daily spotlight plant should change
    /// - Returns: True or false
    private func updatePlant() {
        guard let spotlight = spotlightPlant else {
            // TODO: get context and save core data
            let coreDataPlant = CoreDataSpotlightPlant()
            coreDataPlant.savedPlant = plants.randomElement()
            spotlightPlant = coreDataPlant
            return
        }
        
        // update the spotlight plant if necessary
        if DateHelper.compareDatesOnMonthAndDay(date: Date(), against: spotlight.savedDate) {
            // TODO: get context and save core data
            let coreDataPlant = CoreDataSpotlightPlant()
            coreDataPlant.savedPlant = plants.randomElement()
            spotlightPlant = coreDataPlant
        }
    }
}

