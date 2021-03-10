//
//  PlantRequest.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 09/03/2021.
//  Copyright © 2021 Rebellion Media. All rights reserved.
//

import Foundation

protocol PlantRequestProtocol {
    func fetchPlants() -> [Plant]?
}

class PlantRequest: Request, PlantRequestProtocol {
    func fetchPlants() -> [Plant]? {
        configure(requestType: .file, urlOrFileName: "herbs")
        
        let data = request()
        
        guard data != nil, let plants: PlantContainer = ModelParser.parseJson(data!) else {
            print("An error occurred when attempting to fetch resource")
            return nil
        }
        
        return plants.data
    }
}
