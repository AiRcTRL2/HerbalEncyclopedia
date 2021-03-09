//
//  LabelAndDescriptionCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 28/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

protocol LabelAndDescriptionCellDelegate: class {
    func navigateForwardPressed(indexPath: IndexPath)
}

class LabelAndDescriptionCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var navigateForward: UIButton!
    
    var descriptionList: [String] = []
    var expandedDescription: String = ""
    var indexPath: IndexPath?
    
    weak var delegate: LabelAndDescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    @IBAction func navigateForwardPressed(_ sender: Any) {
        guard navigateForward.isHidden == false else {
            return
        }
        
        if let indexPathUnwrapped = indexPath {
            delegate?.navigateForwardPressed(indexPath: indexPathUnwrapped)
        }
    }
    
    func configureText(_ cellTitle: String?, _ descriptionLabelText: [String]?) {
        title.text = cellTitle
        descriptionList = descriptionLabelText ?? []
        
        if descriptionLabelText?.count == 1 {
            descriptionLabel.text = descriptionLabelText?.first
        } else {
            descriptionLabel.attributedText = StringOperationsHelper.bulletPoints(stringList: descriptionLabelText)

        }
    }
    
    func configureDisclosureIndicator(_ isExpansible: Bool?) {
        self.navigateForward.isHidden = isExpansible == true ? false : true
    }

}
