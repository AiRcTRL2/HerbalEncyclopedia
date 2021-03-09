//
//  DescriptorsViewController.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 29/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

private enum TableViewXibNames {
    static let descriptorCell = "DescriptorCell"
}

private enum CellReuseIdentifiers {
    static let descriptorCell = "descriptorCell"
}

class DefinitionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // tableview nibs
    let descriptorCell = UINib(nibName: TableViewXibNames.descriptorCell, bundle: nil)
    
    /// Counter to monitor tableView setup progress (tableView fetches data from two sources).
    var senderIndexRow: Int?
    
    /// Contains all data responsible for this view controller's operation
    var descriptorViewModel: DefinitionsViewModel?
    
    var dataArrayFromDict: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = descriptorViewModel?.pageTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(descriptorCell, forCellReuseIdentifier: CellReuseIdentifiers.descriptorCell)
        
        tableView.reloadData()
    }
}

extension DefinitionsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        descriptorViewModel?.tableViewDataSource.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellData = descriptorViewModel?.tableViewDataSource else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.descriptorCell) as! DescriptorCell
        
        cell.configure(
            titleText: cellData[indexPath.row].title,
            descriptionText: cellData[indexPath.row].description
        )
        return cell
    }
    
    
}
