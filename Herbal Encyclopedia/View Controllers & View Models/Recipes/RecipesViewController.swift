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
    
    var appContainer = AppDelegate.appContainer
    var recipeCategories: RecipesViewModel?
    
    let cell = UINib(nibName: "ImageAndTitleTableViewCell", bundle: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeCategories = appContainer.buildRecipesViewModel()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cell, forCellReuseIdentifier: "imageAndTitleTableViewCell")
    }
}

extension RecipesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipeCategories?.categories?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageAndTitleTableViewCell") as! ImageAndTitleTableViewCell
        
        guard let model = recipeCategories?.categories?[indexPath.row] else {
            return UITableViewCell()
        }
        
        cell.configure(for: model)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        forwardNavigationPressed(indexPath: indexPath)
    }
}

extension RecipesViewController {
    func forwardNavigationPressed(indexPath: IndexPath) {
        print("presed")
    }
    
}
