//
//  FirstViewController.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit
import SwiftyJSON

class SpotlightViewController: UIViewController {
    @IBOutlet weak var plantName: UILabel!
    @IBOutlet weak var plantImage: CustomImageView!
    
    var plants: [Plant]? {
        if let plantFile = Plant.readJSONFromFile(fileName: "herbs") {
            let plantJson = try! JSON(data: plantFile)
            
            return Plant.parseAllPlants(json: plantJson)
        }
        return nil
    }
    
    var spotlightPlant: Plant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkDayAndPlant()
    }
}


extension SpotlightViewController {
    func checkDayAndPlant() {
        self.spotlightPlant = plants?.randomElement()
        // check current date vs last recorded date
        
        // if date is the same, show the stored spotlight plant
        
        // if the date is not the same, set the current date and show a random new plants from the array
    }
}
