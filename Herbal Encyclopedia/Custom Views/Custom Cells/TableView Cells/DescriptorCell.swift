//
//  DescriptorExplanationCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 29/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class DescriptorCell: UITableViewCell {
    
    @IBOutlet weak var descriptorTitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure (titleText: String, descriptionText: String) {
        descriptorTitleLabel.text = titleText
        descriptorTitleLabel.font = UIFont.systemFont(ofSize: 18, weight: .thin)
        
        descriptionLabel.text = descriptionText
        descriptionLabel.font = UIFont.systemFont(ofSize: 18, weight: .ultraLight)
    }
}
