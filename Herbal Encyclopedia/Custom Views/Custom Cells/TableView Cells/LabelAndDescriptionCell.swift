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
    
    var indexPath: IndexPath?
    
    weak var delegate: LabelAndDescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    /// Alerts the delegate that a tap was detected
    @IBAction func navigateForwardPressed(_ sender: Any) {
        guard navigateForward.isHidden == false else {
            return
        }
        
        if let indexPathUnwrapped = indexPath {
            delegate?.navigateForwardPressed(indexPath: indexPathUnwrapped)
        }
    }
    
    
    func configure(indexPath: IndexPath, spotlightItem: PlantSpotlightItem, delegate: LabelAndDescriptionCellDelegate) {
        self.indexPath = indexPath
        self.delegate = delegate
        
        configureText(spotlightItem.title, spotlightItem.text)
        configureDisclosureIndicator(spotlightItem.isExpansible)
    }
    
    /// Configures the cell's text and underlying data
    /// - Parameters:
    ///   - cellTitle: The data being addressed
    ///   - descriptionLabelText: A list of strings representing the title's main points
    private func configureText(_ cellTitle: String?, _ descriptionLabelText: [String]?) {
        title.text = cellTitle
        
        if descriptionLabelText?.count == 1 {
            descriptionLabel.text = descriptionLabelText?.first
        } else {
            descriptionLabel.attributedText = StringOperationsHelper.bulletPoints(stringList: descriptionLabelText)

        }
    }
    
    
    /// Configures if the cell allows navigation or not
    /// - Parameter isExpansible: A bool indicating whether or not the cell should allow navigation
    private func configureDisclosureIndicator(_ isExpansible: Bool?) {
        self.navigateForward.isHidden = isExpansible == true ? false : true
    }

}
