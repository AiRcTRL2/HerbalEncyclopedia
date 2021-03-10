//
//  SearchViewModel.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 07/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import SwiftyJSON

/// Simple protocol to inform the view model's owner of events
protocol SearchViewModelDelegate: class {
    /// Inform view model's owner that data has been updated
    func dataUpdated()
    /// Inform the listener that a forward navigation was requested
    func navigateToPlant(with viewModel: PlantViewModel)
}

/*
    This class is responsbile for managing the data for SearchViewController.swift. It holds two data sources, a full list and a narrowed down list. The view controller determines which to use based on the count of the filtered list.
 
    Attempting to make this a struct causes the variables, operated on by a mutating function, to cause memory access violations when attempting to read them after the operation is complete.
 **/
class SearchViewModel {
    /// Holds a list of all plants
    var plants: [Plant] = []
    
    /// Holds a list of plants narrowed by the search string
    var plantsNarrowedBySearchString: [Plant] = [] {
        didSet {
            delegate?.dataUpdated()
        }
    }
    
    /// Alerts the listener of changes
    weak var delegate: SearchViewModelDelegate?
    
    init(plants: [Plant]) {
        self.plants = plants
    }
    
    /// Additional setup not handled by the factory setup
    /// - Parameter delegate: The object listening for changes to this class
    func configure(delegate: SearchViewModelDelegate) {
        self.delegate = delegate
    }
    
    /// Currently filters plant list by name and adds it to the filtered list property & informs the caller of it's result
    func filterList(string: String) {
        let plantsFiltered: [Plant]? = self.plants.filter {
            $0.plantInfo.name.lowercased().contains(string)
        }
                
        if let plantsFilteredUnwrapped = plantsFiltered {
            self.plantsNarrowedBySearchString = plantsFilteredUnwrapped
        } else {
            self.plantsNarrowedBySearchString = []
        }
        
        delegate?.dataUpdated()
    }
    
    func forwardNavigationPressed(indexPath: IndexPath, viewModelBuilder: () -> PlantViewModel) {
        let plant = self.plantsNarrowedBySearchString.count > 0 ? self.plantsNarrowedBySearchString[indexPath.row] : self.plants[indexPath.row]
        
        let viewModel: PlantViewModel = viewModelBuilder()
        
        let plantModel = CoreDataSpotlightPlant()
        plantModel.savedPlant = plant
        viewModel.spotlightPlant = plantModel
        
        delegate?.navigateToPlant(with: viewModel)
    }
}
