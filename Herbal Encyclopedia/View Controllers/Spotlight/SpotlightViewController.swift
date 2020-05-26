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
    
    // description labels
    @IBOutlet weak var warningDescriptionLabel: UILabel!
    @IBOutlet weak var latinNameDescLabel: UILabel!
    @IBOutlet weak var aliasLabel: UILabel!
    @IBOutlet weak var plantFamilyDescLabel: UILabel!
    @IBOutlet weak var nativeRegionsDescLabel: UILabel!
    @IBOutlet weak var growthHeightDescLabel: UILabel!
    @IBOutlet weak var primaryUseDescLabel: UILabel!
    @IBOutlet weak var secondaryUseDescLabel: UILabel!
    @IBOutlet weak var tertiaryUseDescLabel: UILabel!
    @IBOutlet weak var otherUsesDescLabel: UILabel!
    @IBOutlet weak var growthLocationAndConditionsDescLabel: UILabel!
    @IBOutlet weak var activeConstituentsDescLabel: UILabel!
    @IBOutlet weak var plantActionsDescLabel: UILabel!
    
    // stack views
    @IBOutlet weak var warningStackView: UIStackView!
    @IBOutlet weak var latinNameStackView: UIStackView!
    @IBOutlet weak var aliasStackView: UIStackView!
    @IBOutlet weak var plantFamilyStackView: UIStackView!
    @IBOutlet weak var nativeToStackView: UIStackView!
    @IBOutlet weak var growthHeightStackView: UIStackView!
    @IBOutlet weak var primaryUseStackView: UIStackView!
    @IBOutlet weak var secondaryUseStackView: UIStackView!
    @IBOutlet weak var tertiaryUseStackView: UIStackView!
    @IBOutlet weak var otherUsesStackView: UIStackView!
    @IBOutlet weak var grownInStackView: UIStackView!
    @IBOutlet weak var activeConstituentsStackView: UIStackView!
    @IBOutlet weak var plantActionsStackView: UIStackView!
    
    
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
        updateView()
    }
}


extension SpotlightViewController {
    func checkDayAndPlant() {
        self.spotlightPlant = plants?.randomElement()
        print("This is the plant \n", self.spotlightPlant)
        // check current date vs last recorded date
        
        // if date is the same, show the stored spotlight plant
        
        // if the date is not the same, set the current date and show a random new plants from the array
    }
    
    func updateView() {
        if let plant = self.spotlightPlant {
            self.plantName.text = plant.plantInformation.name
            self.plantImage.image = UIImage(named: plant.localImageName)
            
            // plant information
            self.latinNameDescLabel.text = plant.plantInformation.latinName
            self.aliasLabel.text = plant.plantInformation.alias
            self.plantFamilyDescLabel.text = plant.plantInformation.plantFamily
            self.nativeRegionsDescLabel.attributedText = bulletPointAttributedString(stringList: plant.plantInformation.nativeTo)
            
            // growth information
            self.growthHeightDescLabel.text = plant.growthInformation.growthHeight
            self.growthLocationAndConditionsDescLabel.text = plant.growthInformation.growsIn
            
            
            // use information
            self.primaryUseDescLabel.text = plant.plantUses.primaryUse
            self.secondaryUseDescLabel.text = plant.plantUses.secondaryUse
            self.tertiaryUseDescLabel.text = plant.plantUses.tertiaryUse
            self.otherUsesDescLabel.attributedText = bulletPointAttributedString(stringList: plant.plantUses.otherUses)
            
            // plant science
            self.activeConstituentsDescLabel.attributedText = bulletPointAttributedString(stringList: plant.plantScience.keyConstituents)
            self.plantActionsDescLabel.attributedText = bulletPointAttributedString(stringList: plant.bodilyEffects.keyActions)
            
        }
        
        latinNameStackView.addBorder(toSide: .Top, withColor: UIColor.lightGray.cgColor, andThickness: 0.5)
        aliasStackView.addBorder(toSide: .Top, withColor: UIColor.lightGray.cgColor, andThickness: 0.5)
    }
}
