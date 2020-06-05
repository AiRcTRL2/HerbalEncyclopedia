//
//  DescriptorTitleCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 29/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class DescriptorTitleCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(titleText: String) {
        self.titleLabel.text = titleText
    }
}
