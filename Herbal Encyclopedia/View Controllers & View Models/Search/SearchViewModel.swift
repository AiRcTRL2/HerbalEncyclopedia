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
}

/*
    This class is responsbile for managing the data for SearchViewController.swift. It holds two data sources, a full list and a narrowed down list. The view controller determines which to use based on the count of the filtered list.
 
    Attempting to make this a struct causes the variables, operated on by a mutating function, to cause memory access violations when attempting to read them after the operation is complete.
 **/
class SearchViewModel {
    /// Holds a list of all plants
    var plants: [Plant]?
    
    /// Holds a list of plants narrowed by the search string
    var plantsNarrowedBySearchString: [Plant] = [] {
        didSet {
            delegate?.dataUpdated()
        }
    }
    
    /// Alerts the listener of changes
    weak var delegate: SearchViewModelDelegate?
    
    init() {
        let plantContainer: PlantContainer? = ModelParser.parseJson("herbs")
        plants = plantContainer?.data
    }
    
    /// Currently filters plant list by name and adds it to the filtered list property & informs the caller of it's result
    func filterList(string: String, completion: (_ dataUpdated: Bool) -> ()) {
        let plantsFiltered: [Plant]? = self.plants?.filter({ (plant) -> Bool in
            plant.plantInfo.name.contains(string)
        })
                
        if let plantsFilteredUnwrapped = plantsFiltered {
            self.plantsNarrowedBySearchString = plantsFilteredUnwrapped
            completion(true)
        } else {
            self.plantsNarrowedBySearchString = []
            completion(false)
        }
    }
}
