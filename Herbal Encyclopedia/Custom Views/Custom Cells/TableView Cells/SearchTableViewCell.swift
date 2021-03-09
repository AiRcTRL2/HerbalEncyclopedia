//
//  SearchTableViewCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

protocol SearchTableViewCellDelegate: class {
    func forwardNavigationPressed(cellIndexPath: IndexPath, plant: Plant?)
}

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchImage: CustomImageView!
    @IBOutlet weak var searchItemText: UILabel!
    
    weak var delegate: SearchTableViewCellDelegate?
    var cellIndex: IndexPath?
    var plant: Plant?
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    @IBAction func forwardNavigationPressed(_ sender: Any) {
        if let plantUnwrapped = plant, let cellIndexUnwrapped = cellIndex {
            delegate?.forwardNavigationPressed(cellIndexPath: cellIndexUnwrapped, plant: plantUnwrapped)
        } else if let cellIndexUnwrapped = cellIndex {
            delegate?.forwardNavigationPressed(cellIndexPath: cellIndexUnwrapped, plant: nil)
        }
    }
    
    func configure() {
        if let plantUnwrapped = plant {
            self.searchImage.image = UIImage(named: plantUnwrapped.localImageName)
            self.searchItemText.text = plantUnwrapped.plantInfo.name
        }
    }
}
