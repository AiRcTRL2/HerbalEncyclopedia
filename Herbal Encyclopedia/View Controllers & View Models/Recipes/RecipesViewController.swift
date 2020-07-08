//
//  RecipesViewController.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/07/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class RecipesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    let recipeCategories = RecipesViewModel()
    
    let cell = UINib(nibName: "SearchTableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell, forCellReuseIdentifier: "searchCell")
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeCategories.categories?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell") as! SearchTableViewCell
        cell.searchItemText?.text = recipeCategories.categories?.data[indexPath.row].name.capitalized
        cell.searchImage.image = nil
        cell.delegate = self
        cell.cellIndex = indexPath
        return cell
    }
    
}

extension RecipesViewController: SearchTableViewCellDelegate {
    func forwardNavigationPressed(cellIndexPath: IndexPath, plant: Plant?) {
        print("pressed")
    }
    
    
}
