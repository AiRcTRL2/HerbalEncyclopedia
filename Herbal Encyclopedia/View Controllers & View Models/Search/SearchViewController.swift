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
    var searchViewModel: SearchViewModel?
    
    let searchTableViewCellNib = UINib(nibName: "ImageAndTitleTableViewCell", bundle: nil)
    
    // MARK: View Controller Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        searchViewModel = appContainer?.buildSearchViewModel()
        searchViewModel?.configure(delegate: self)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(searchTableViewCellNib, forCellReuseIdentifier: "imageAndTitleTableViewCell")
        
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
            return searchViewModel?.plants.count ?? 0
        } else {
            return searchViewModel?.plantsNarrowedBySearchString.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageAndTitleTableViewCell") as! ImageAndTitleTableViewCell
        
        guard searchViewModel != nil else {
            return UITableViewCell()
        }
        
        let plant = searchViewModel!.plantsNarrowedBySearchString.count > 0 ? searchViewModel!.plantsNarrowedBySearchString[indexPath.row] : searchViewModel!.plants[indexPath.row]
        

        cell.configure(for: plant)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard appContainer != nil else {
            return
        }
        
        searchViewModel?.forwardNavigationPressed(
            indexPath: indexPath,
            viewModelBuilder: appContainer!.buildPlantViewModel
        )
    }
    
}

extension SearchViewController: SearchViewModelDelegate {
    func navigateToPlant(with viewModel: PlantViewModel) {
        presentPlantFromSearchController(plantViewModel: viewModel)
    }
    
    func dataUpdated() {
        updateSearchResults()
    }
}

extension SearchViewController {
    
    /// Call back function for textField observer for when text has changed
    @objc func textFieldDidChange() {
        searchViewModel?.filterList(string: searchTextField.text?.lowercased() ?? "")
    }
    
    func updateSearchResults() {
        if searchViewModel?.plantsNarrowedBySearchString.count == 0 && searchTextField.text?.isEmpty == false {
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
