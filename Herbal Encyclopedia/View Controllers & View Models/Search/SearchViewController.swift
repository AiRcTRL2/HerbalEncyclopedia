//
//  SecondViewController.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit
import SwiftyJSON

/// This class handles the interaction in the search view, and passes information forward to a Plant view when required
/// TODO: As iOS less than 13 won't be supported, we need to migrate this viewController to using Combine. This view should be significantly more reactive than is here.
class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPlantsFoundLabel: UILabel!
    
    weak var appContainer = AppDelegate.appContainer
    
    let searchTableViewCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    var searchViewModel = SearchViewModel()
    
    // MARK: View Controller Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(searchTableViewCellNib, forCellReuseIdentifier: "searchCell")
        
        noPlantsFoundLabel.isHidden = true
        
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: TableView Configuration
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // check if the search filter is empty or not
        if self.searchTextField.text?.isEmpty == true {
            return searchViewModel.plants?.count ?? 0
        } else {
            return searchViewModel.plantsNarrowedBySearchString.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        
        // determine which data source should populate this list
        cell.plant = searchViewModel.plantsNarrowedBySearchString.count > 0 ? searchViewModel.plantsNarrowedBySearchString[indexPath.row] : searchViewModel.plants?[indexPath.row]
        
        // cell setup
        cell.delegate = self
        cell.cellIndex = indexPath
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cell.configure()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // add action on cell tap
        if let plant = searchViewModel.plantsNarrowedBySearchString.count > 0 ? searchViewModel.plantsNarrowedBySearchString[indexPath.row] : searchViewModel.plants?[indexPath.row] {
            forwardNavigationPressed(cellIndexPath: indexPath, plant: plant)
        }
    }
    
}

// MARK: Cell tap delegate
extension SearchViewController: SearchTableViewCellDelegate {
    func forwardNavigationPressed(cellIndexPath: IndexPath, plant: Plant?) {
        if let plantUnwrapped = plant, let appContainer = appContainer {
            let viewModel = appContainer.buildPlantViewModel()
            let plantModel = CoreDataSpotlightPlant()
            plantModel.savedPlant = plantUnwrapped
            viewModel.spotlightPlant = plantModel
            
            presentPlantFromSearchController(plantViewModel: viewModel)
        }
    }
}

// MARK: Additional functions for search & view update
extension SearchViewController {
    
    /// Call back function for textField observer for when text has changed
    @objc func textFieldDidChange() {
        searchViewModel.filterList(string: searchTextField.text ?? "") { completion in
            if completion {
                updateViews()
            }
        }
    }
    
    func updateViews() {
        if searchViewModel.plantsNarrowedBySearchString.count == 0 && searchTextField.text?.isEmpty == false {
            tableView.isHidden = true
            noPlantsFoundLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noPlantsFoundLabel.isHidden = true
        }
    }
}

// MARK: New view controller presentation
extension SearchViewController {
    func presentPlantFromSearchController(plantViewModel: PlantViewModel) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Spotlight") as? PlantViewController
        
        if let controllerUnwrapped = controller {
            // set the new plant
            controllerUnwrapped.plantViewModel = plantViewModel
            // disable main screen only functions
            controllerUnwrapped.didFlowComeFromSearchViewController = true
            self.navigationController?.pushViewController(controllerUnwrapped, animated: true)
        }
    }
}
