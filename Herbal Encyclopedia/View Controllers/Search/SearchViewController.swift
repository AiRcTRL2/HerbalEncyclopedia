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
    
    let searchTableViewCellNib = UINib(nibName: "SearchTableViewCell", bundle: nil)
    
    var plants: [Plant]? {
        if let plantFile = Plant.readJSONFromFile(fileName: "herbs") {
            let plantJson = try! JSON(data: plantFile)
            
            return Plant.parseAllPlants(json: plantJson)
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(searchTableViewCellNib, forCellReuseIdentifier: "searchCell")
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        plants?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.plant = plants?[indexPath.row]
        cell.delegate = self
        cell.cellIndex = indexPath
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let plant = plants?[indexPath.row] {
            forwardNavigationPressed(cellIndexPath: indexPath, plant: plant)
        }
    }
    
}

extension SearchViewController: SearchTableViewCellDelegate {
    func forwardNavigationPressed(cellIndexPath: IndexPath, plant: Plant) {
        print("yup")
    }
    
    
}

