//
//  SearchTableViewCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/06/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

class ImageAndTitleTableViewCell: UITableViewCell {
    @IBOutlet weak var customImageView: CustomImageView!
    @IBOutlet weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    func configure(for model: Plant?) {
        configureCellStyle()
        
        if let plantUnwrapped = model {
            self.customImageView.image = UIImage(named: plantUnwrapped.localImageName)
            self.titleLabel.text = plantUnwrapped.plantInfo.name
        }
    }
    
    func configure(for model: RecipeCategoryModel?) {
        configureCellStyle()
        
        if let category = model {
            self.customImageView.image = UIImage(named: category.categoryImage)
            self.titleLabel.text = category.name.capitalized
        }
    }
    
    private func configureCellStyle() {
        separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
}
