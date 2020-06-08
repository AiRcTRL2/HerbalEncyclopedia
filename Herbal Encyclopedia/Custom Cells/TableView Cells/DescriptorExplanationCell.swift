//
//  DescriptorExplanationCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 29/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class DescriptorExplanationCell: UITableViewCell {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure (descriptionText: String) {
        self.descriptionLabel.text = descriptionText
        self.descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
    }
}
