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

    // title labels
    @IBOutlet weak var latinNameTitleLabel: UILabel!
    @IBOutlet weak var aliasTitleLabel: UILabel!
    @IBOutlet weak var plantFamilyTitleLabel: UILabel!
    @IBOutlet weak var nativeToTitleLabel: UILabel!
    @IBOutlet weak var growthHeightTitleLabel: UILabel!
    @IBOutlet weak var primaryUseTitleLabel: UILabel!
    @IBOutlet weak var secondaryUseTitleLabel: UILabel!
    @IBOutlet weak var tertiaryUseTitleLabel: UILabel!
    @IBOutlet weak var otherUsesTitleLabel: UILabel!
    @IBOutlet weak var growthLocationAndTitleLabel: UILabel!
    @IBOutlet weak var activeConstituentsTitleLabel: UILabel!
    @IBOutlet weak var plantActionsTitleLabel: UILabel!
    
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
        updatePlant()
        configureBorders()
    }
    
}


extension SpotlightViewController {
    func checkDayAndPlant() {
        self.spotlightPlant = plants?.randomElement()
        print("This is the plant \n", self.spotlightPlant as Any)
        // check current date vs last recorded date
        
        // if date is the same, show the stored spotlight plant
        
        // if the date is not the same, set the current date and show a random new plants from the array
    }
    
    func updatePlant() {
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
    }
    
    func configureBorders() {
        // offsetX should be the negative of the leading padding to correctly cover the entire screen

        aliasTitleLabel.addBorder(toSide: .FullScreenWidthTop, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.5, offsetX: -15)
//        latinNameTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 10)
//
//        nativeToTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 10)
//
//        otherUsesTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 0)
//
//
//        growthLocationAndTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 0)
//        activeConstituentsTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 14)
//
//        plantActionsTitleLabel.addBorder(toSide: .FullScreenWidthBottom, withColor: ColourHelper.separatorGrey().cgColor, andThickness: 0.2, offsetX: -15, offsetY: 14)
    }
    
}
