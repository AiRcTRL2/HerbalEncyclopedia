//
//  SecondViewController.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit
import SwiftyJSON

class SearchViewController: UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noPlantsFoundLabel: UILabel!
    
    let searchTableViewCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    
    var plants: [Plant]? {
        if let plantFile = Plant.readJSONFromFile(fileName: "herbs") {
            let plantJson = try! JSON(data: plantFile)
            return Plant.parseAllPlants(json: plantJson).sorted(by: {$0.plantInformation.name > $1.plantInformation.name})
        }
        return nil
    }
    
    var plantsNarrowedBySearchString: [Plant] = [Plant]() {
        didSet {
            updateViews()
        }
    }
    
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchTextField.text?.isEmpty == true {
            return plants?.count ?? 0
        } else {
            return self.plantsNarrowedBySearchString.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        
        cell.plant = self.plantsNarrowedBySearchString.count > 0 ? self.plantsNarrowedBySearchString[indexPath.row] : self.plants?[indexPath.row]
        
        cell.delegate = self
        cell.cellIndex = indexPath
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let plant = self.plantsNarrowedBySearchString.count > 0 ? self.plantsNarrowedBySearchString[indexPath.row] : plants?[indexPath.row] {
            forwardNavigationPressed(cellIndexPath: indexPath, plant: plant)
        }
    }
    
}

extension SearchViewController: SearchTableViewCellDelegate {
    func forwardNavigationPressed(cellIndexPath: IndexPath, plant: Plant) {
        presentPlantFromSearchController(plant: plant)
    }
}

// MARK: Additional functions
extension SearchViewController {
    @objc func textFieldDidChange() {
        filterList(string: searchTextField.text ?? "")
    }
    
    func filterList(string: String) {
        let plantsFiltered: [Plant]? = self.plants?.filter({ (plant) -> Bool in
            plant.plantInformation.name.contains(string)
        })
        
        if let plantsFilteredUnwrapped = plantsFiltered {
            self.plantsNarrowedBySearchString = plantsFilteredUnwrapped
        } else {
            self.plantsNarrowedBySearchString = [Plant]()
        }
    }
    
    func updateViews() {
        if self.plantsNarrowedBySearchString.count == 0 && searchTextField.text?.isEmpty == false {
            tableView.isHidden = true
            noPlantsFoundLabel.isHidden = false
        } else {
            tableView.isHidden = false
            noPlantsFoundLabel.isHidden = true
        }
    }
}

extension SearchViewController {
    func presentPlantFromSearchController(plant: Plant) {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "Spotlight") as? SpotlightViewControllerV2
        
        if let controllerUnwrapped = controller {
            // set the new plant
            controllerUnwrapped.spotlightPlant = plant
            // disable main screen only functions
            controllerUnwrapped.didFlowComeFromSearchViewController = true
            self.navigationController?.pushViewController(controllerUnwrapped, animated: true)
        }
    }
}
