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

private enum ReuseIDs {
    static let titleAndImageCell = "TitleAndImageCell"
    static let warningCell = "WarningCell"
    static let labelAndDescriptionCell = "LabelAndDescriptionCell"
}

private enum XibNames {
    static let titleAndImage = "TitleAndImageCell"
    static let warningCell = "WarningCell"
    static let labelAndDescriptionCell = "LabelAndDescriptionCell"
}

private enum SegueIDs {
    static let descriptorsVC = "aDescriptor"
}

class PlantViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// Helps build MVVM view models
    weak var viewModelFactory = AppDelegate.appContainer
    var plantViewModel: PlantViewModel?
            
    /// TableView Xibs
    let titleAndImageCell = UINib(nibName: XibNames.titleAndImage, bundle: nil)
    let warningCell = UINib(nibName: XibNames.warningCell, bundle: nil)
    let labelAndDescriptionCell = UINib(nibName: XibNames.labelAndDescriptionCell, bundle: nil)
    
    /// Determines some actions that will not be carried out if the view controller is being used by the search view controller
    var didFlowComeFromSearchViewController: Bool = false
    
    /// Builds the viewModel and sets up the tableView
    override func viewDidLoad() {
        super.viewDidLoad()
        
        plantViewModel = viewModelFactory?.buildPlantViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(titleAndImageCell, forCellReuseIdentifier: ReuseIDs.titleAndImageCell)
        tableView.register(warningCell, forCellReuseIdentifier: ReuseIDs.warningCell)
        tableView.register(labelAndDescriptionCell, forCellReuseIdentifier: ReuseIDs.labelAndDescriptionCell)
        
    }
    
    /// Hides the navigation controller on appear if this is the root view controller and sets the navigation item title
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if didFlowComeFromSearchViewController == false {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
        navigationController?.navigationBar.tintColor = .black
        
        if let plant = plantViewModel?.spotlightPlant?.savedPlant {
            self.navigationItem.title = plant.plantInfo.name
        }

    }
    
    /// Hides the navigation bar when leaving the view controller if this is not the root view controller
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if didFlowComeFromSearchViewController == false {
            navigationController?.setNavigationBarHidden(false, animated: animated)
        }
    }
}

extension PlantViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = plantViewModel?.tableViewRepresentable.count else {
            return 0
        }
        
        return count + 2
    }
    
    /// Determines the type of cell to build based on its index, then configures those cells for consumption
    /// - Returns: A configured cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let plant = plantViewModel?.spotlightPlant?.savedPlant {
            switch indexPath.row {
            case 0:
                // 0 row = Photo
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.titleAndImageCell) as! TitleAndImageCell
                
                cell.configure(plantName: plant.plantInfo.name, plantImageName: plant.localImageName)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                
                return cell
            case 1:
                // 1st row = Warnings
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.warningCell) as! WarningCell
                
                cell.warningLabel.attributedText = StringOperationsHelper.bulletPoints(stringList: plant.plantInfo.warnings)
                cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
                
                return cell
            default:
                // For all other rows, label and description cell applies.
                // account for above two cells not contained within datasourcce list
                let adjustedIndex = IndexPath(row: indexPath.row-2, section: indexPath.section)

                // Fetch the cell data
                guard let spotlightItem = plantViewModel?.tableViewRepresentable[adjustedIndex.row]  else {
                    return UITableViewCell()
                }
                
                let labelAndDescCell = buildSpotlightItemCell(indexPath: adjustedIndex, spotlightItem: spotlightItem, delegate: self)
                
                return labelAndDescCell
                
            }
        }
        
        return UITableViewCell()
    }
    
    /// Builds a spotlight item table view cell for the Plant
    /// - Parameters:
    ///   - indexPath: The current index path to build
    ///   - spotlightItem: The plant data
    ///   - delegate: The responder to actions from the cell
    /// - Returns: A configured LabelAndDescriptionCell
    func buildSpotlightItemCell(indexPath: IndexPath, spotlightItem: PlantSpotlightItem, delegate: LabelAndDescriptionCellDelegate) -> LabelAndDescriptionCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIDs.labelAndDescriptionCell) as! LabelAndDescriptionCell
        
        // configure the cell text
        cell.configure(
            indexPath: indexPath,
            spotlightItem: spotlightItem,
            delegate: self
        )
        
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        return cell
    }
    
    /// Alerts the view model to a cell tap
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? LabelAndDescriptionCell
        cell?.navigateForwardPressed(self)
    }
}

extension PlantViewController: LabelAndDescriptionCellDelegate {
    /// Validates the navigation forward request, fetches information required for the segue, then asks the viewModelFactory to prepare the view.
    /// - Parameter indexPath: The tableView position of the tapped cell
    func navigateForwardPressed(indexPath: IndexPath) {
        if indexPath.row > 1 {
            guard
                let spotlightItem = plantViewModel?.tableViewRepresentable[indexPath.row],
                let plant = plantViewModel?.spotlightPlant?.savedPlant else {
                return
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: SegueIDs.descriptorsVC) as! DefinitionsViewController
            
            vc.descriptorViewModel = viewModelFactory?.buildDescriptorViewModel()
            vc.descriptorViewModel?
                .configure(
                    pageTitle: spotlightItem.title,
                    definitionHeadings: spotlightItem.text,
                    describedPlant: plant
                )
                        
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension PlantViewController: PlantDidLoadDelegate {
    func plantLoadedSuccessfully() {
        tableView.reloadData()
    }
}
