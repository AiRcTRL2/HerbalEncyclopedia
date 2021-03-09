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

struct PlantRequest: PlantRequestProtocol {
    let request = Request()
    
    func fetchPlants() -> [Plant]? {
        request.configure(requestType: .file, urlOrFileName: "herbs")
        
        guard let plants: [Plant]? = request.request() else {
            print("An error occurred when attempting to fetch resource")
            return nil
        }
        
        return plants
    }
    
    
}
