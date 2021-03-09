//
//  TitleAndImageCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 28/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class TitleAndImageCell: UITableViewCell {
    @IBOutlet weak var plantNameLabel: UILabel!
    @IBOutlet weak var plantImageView: CustomImageView!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configure(plantName: String, plantImageName: String) {
        self.plantNameLabel.text = plantName
        self.plantImageView.image = UIImage(named: plantImageName)
    }
}
