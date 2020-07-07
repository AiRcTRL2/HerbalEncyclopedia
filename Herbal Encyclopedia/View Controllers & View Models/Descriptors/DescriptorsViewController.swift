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
    static let descriptorTitleCell = "DescriptorTitleCell"
    static let descriptorExplanationCell = "DescriptorExplanationCell"
}

private enum CellReuseIdentifiers {
    static let descriptorTitleCell = "descriptorTitleCell"
    static let descriptorExplanationCell = "descriptorExplanationCell"
}

class DescriptorsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    // tableview nibs
    let descriptorTitle = UINib(nibName: TableViewXibNames.descriptorTitleCell, bundle: nil)
    let descriptorExplanation = UINib(nibName: TableViewXibNames.descriptorExplanationCell, bundle: nil)
    
    /// Counter to monitor tableView setup progress (tableView fetches data from two sources).
    var senderIndexRow: Int?
    
    /// Contains all data responsible for this view controller's operation
    var cellDataToDescribe: DescriptorViewModel?
    
    var dataArrayFromDict: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = cellDataToDescribe?.pageTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(descriptorTitle, forCellReuseIdentifier: CellReuseIdentifiers.descriptorTitleCell)
        tableView.register(descriptorExplanation, forCellReuseIdentifier: CellReuseIdentifiers.descriptorExplanationCell)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if cellDataToDescribe != nil {
            cellDataToDescribe?.parseExplanationsFromTitles()
            tableView.reloadData()
        }
        
    }
}

extension DescriptorsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.cellDataToDescribe?.tableViewDataSource?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.descriptorTitleCell) as! DescriptorTitleCell
            cell.configure(titleText: cellDataToDescribe?.descriptorTitles[indexPath.row] ?? "Oops! Something went wrong with getting the title.")
            return cell
        default:
            if indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.descriptorTitleCell) as! DescriptorTitleCell
                cell.configure(titleText: self.cellDataToDescribe?.tableViewDataSource?[indexPath.row] ?? "Oops! Something went wrong with getting the title.")
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: CellReuseIdentifiers.descriptorExplanationCell) as! DescriptorExplanationCell
                cell.configure(descriptionText: self.cellDataToDescribe?.tableViewDataSource?[indexPath.row] ?? "Oops! We couldn't retrieve the explanation for this. Looks like something might be broken.")
                return cell
            }

        }
    }
    
    
}
