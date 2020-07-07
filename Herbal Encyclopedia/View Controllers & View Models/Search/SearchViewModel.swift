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
    
    var plants: [Plant]? {
        if let plantFile = Plant.readJSONFromFile(fileName: "herbs") {
            let plantJson = try! JSON(data: plantFile)
            return Plant.parseAllPlants(json: plantJson).sorted(by: {$0.plantInformation.name > $1.plantInformation.name})
        }
        return nil
    }
    
    var plantsNarrowedBySearchString: [Plant] = [] {
        didSet {
            delegate?.dataUpdated()
        }
    }
    
    weak var delegate: SearchViewModelDelegate?
    
    /// Currently filters plant list by name and adds it to the filtered list property & informs the caller of it's result
    func filterList(string: String, completion: (_ dataUpdated: Bool) -> ()) {
        let plantsFiltered: [Plant]? = self.plants?.filter({ (plant) -> Bool in
            plant.plantInformation.name.contains(string)
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
