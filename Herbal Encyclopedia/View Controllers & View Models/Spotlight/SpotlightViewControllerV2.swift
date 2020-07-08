//
//  SpotlightViewControllerV2.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 28/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

private enum TableViewReuseIdentifiers {
    static let titleAndImageCell = "TitleAndImageCell"
    static let warningCell = "WarningCell"
    static let labelAndDescriptionCell = "LabelAndDescriptionCell"
}

private enum TableViewXibNames {
    static let titleAndImage = "TitleAndImageCell"
    static let warningCell = "WarningCell"
    static let labelAndDescriptionCell = "LabelAndDescriptionCell"
}

private enum CellTitles {
    static let stringValue: [Int: String] =
        [
             0: "Latin name",
             1: "Alias",
             2: "Plant species",
             3: "Native to",
             4: "Growth height",
             5: "Grows in",
             6: "Primary use",
             7: "Secondary use",
             8: "Tertiary use",
             9: "Other uses",
             10: "Active constituents",
             11: "Volatile oils",
             12: "Bodily effects",
             13: "Preparation"
        ]
}

private enum JSONFileNameIdentifiers {
    static let forCellTitles: [String: String] =
    [
        "Plant species": "plant_species",
        "Active constituents": "key_constituents",
        "Bodily effects": "body_effects",
        "Volatile oils": "volatile_oils",
        "Preparation": "preparation_methods"
    ]
}

private enum SegueIdentifiers {
    static let descriptorsVC = "aDescriptor"
}

class SpotlightViewControllerV2: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var plants: [Plant]? {
        if let plantFile = Plant.readJSONFromFile(fileName: "herbs") {
            let plantJson = try! JSON(data: plantFile)
            
            return Plant.parseAllPlants(json: plantJson)
        }
        return nil
    }
    
    var spotlightPlant: Plant?
    var plantPropertiesForTableView: [Any] = []
    
    var currentSelectedCellData: [String: [String]] = [:]
    
    let titleAndImageCell = UINib(nibName: TableViewXibNames.titleAndImage, bundle: nil)
    let warningCell = UINib(nibName: TableViewXibNames.warningCell, bundle: nil)
    let labelAndDescriptionCell = UINib(nibName: TableViewXibNames.labelAndDescriptionCell, bundle: nil)
    
    // determines some actions that will not be carried out if the view controller is being used by the search view controller
    var didFlowComeFromSearchViewController: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(titleAndImageCell, forCellReuseIdentifier: TableViewReuseIdentifiers.titleAndImageCell)
        tableView.register(warningCell, forCellReuseIdentifier: TableViewReuseIdentifiers.warningCell)
        tableView.register(labelAndDescriptionCell, forCellReuseIdentifier: TableViewReuseIdentifiers.labelAndDescriptionCell)
        
        if didFlowComeFromSearchViewController == false {
            checkDayAndPlant()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        createTableViewDataSourceFromPlantModel()
        if didFlowComeFromSearchViewController == false {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        navigationController?.navigationBar.tintColor = .black
        
        if let plant = spotlightPlant {
            self.navigationItem.title = plant.plantInformation.name
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if didFlowComeFromSearchViewController == false {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
    
    
    
    func createTableViewDataSourceFromPlantModel() {
        if let plant = spotlightPlant {
            // reset list as this is a reused view controller
            plantPropertiesForTableView = []
            // must follow same order as cellTitles enum
            plantPropertiesForTableView.append(plant.plantInformation.latinName)
            plantPropertiesForTableView.append(plant.plantInformation.alias)
            plantPropertiesForTableView.append(plant.plantInformation.plantFamily)
            plantPropertiesForTableView.append(plant.plantInformation.nativeTo)
            plantPropertiesForTableView.append(plant.growthInformation.growthHeight)
            plantPropertiesForTableView.append(plant.growthInformation.growsIn)
            plantPropertiesForTableView.append(plant.plantUses.primaryUse)
            plantPropertiesForTableView.append(plant.plantUses.secondaryUse)
            plantPropertiesForTableView.append(plant.plantUses.tertiaryUse)
            plantPropertiesForTableView.append(plant.plantUses.otherUses)
            plantPropertiesForTableView.append(plant.plantScience.keyConstituents)
            plantPropertiesForTableView.append(plant.plantScience.volatileOils)
            plantPropertiesForTableView.append(plant.bodilyEffects.keyActions)
            plantPropertiesForTableView.append(plant.preparations.methodsOfPreparation)
            
            tableView.reloadData()
        }
    }
}

extension SpotlightViewControllerV2: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2 + plantPropertiesForTableView.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let plant = spotlightPlant {
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifiers.titleAndImageCell) as! TitleAndImageCell
                cell.configure(plantName: plant.plantInformation.name, plantImageName: plant.localImageName)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifiers.warningCell) as! WarningCell
                cell.warningLabel.attributedText = bulletPointAttributedString(stringList: plant.plantInformation.warnings)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                return cell
            default:
                // account for above two cells not contained within datasourcce list
                let adjustedIndex = indexPath.row - 2
                let cell = tableView.dequeueReusableCell(withIdentifier: TableViewReuseIdentifiers.labelAndDescriptionCell) as! LabelAndDescriptionCell
                cell.title.text = CellTitles.stringValue[adjustedIndex]
                
                // check if the value to be insterted is string or attributed string
                if plantPropertiesForTableView[adjustedIndex] is String {
                    cell.descriptionLabel.text = plantPropertiesForTableView[adjustedIndex] as? String
                    // used for forward segues
                    cell.descriptionOrDescList = [plantPropertiesForTableView[adjustedIndex]] as? [String]
                } else if plantPropertiesForTableView[adjustedIndex] is [String] {
                    // set the attributed string using bullet point creation function
                    cell.descriptionLabel.attributedText = bulletPointAttributedString(stringList: plantPropertiesForTableView[adjustedIndex] as! [String])
                    // set the raw data which may be used for forward segues in the future
                    cell.descriptionOrDescList = plantPropertiesForTableView[adjustedIndex] as! [String]
                }
                
                // set the flag as to whether this cell requires an expanded description segue or not (flag is also the file name of the json file where those descriptions should be located for lookup)
                if let cellTitle = CellTitles.stringValue[adjustedIndex] {
                    cell.requiresExpandedDescriptionJsonIdentifier = JSONFileNameIdentifiers.forCellTitles[cellTitle]
                    cell.titleString = CellTitles.stringValue[adjustedIndex]!
                } else {
                    cell.requiresExpandedDescriptionJsonIdentifier = nil
                }
                
                cell.indexPath = indexPath
                cell.delegate = self
                cell.configure()
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                return cell
                
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateForwardPressed(indexPath: indexPath)
    }
}

extension SpotlightViewControllerV2 {
    func checkDayAndPlant() {
        self.spotlightPlant = plants?.randomElement()
        // check current date vs last recorded date
        
        // if date is the same, show the stored spotlight plant
        
        // if the date is not the same, set the current date and show a random new plants from the array
    }
}

extension SpotlightViewControllerV2: LabelAndDescriptionCellDelegate {
    func navigateForwardPressed(indexPath: IndexPath) {
        if indexPath.row > 1 {
            let cell = tableView.cellForRow(at: indexPath) as! LabelAndDescriptionCell
            if cell.requiresExpandedDescriptionJsonIdentifier != nil {
                let destinationViewController = storyboard?.instantiateViewController(withIdentifier: SegueIdentifiers.descriptorsVC) as! DescriptorsViewController
                destinationViewController.cellDataToDescribe = DescriptorViewModel(pageTitle: cell.titleString, jsonFileIdentifier: cell.requiresExpandedDescriptionJsonIdentifier, descriptorTitles: cell.descriptionOrDescList as! [String], descriptorExplanations: nil, describingPlant: self.spotlightPlant)
                // update the view model by performing the description lookup
                destinationViewController.cellDataToDescribe?.parseExplanationsFromTitles()
                
                navigationController?.pushViewController(destinationViewController, animated: true)
            }
        }
    }
}
