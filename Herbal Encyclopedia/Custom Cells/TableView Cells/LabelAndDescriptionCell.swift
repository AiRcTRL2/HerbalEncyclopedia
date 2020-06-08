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
    
    var titleString: String = ""
    var descriptionOrDescList: [Any]? = []
    var requiresExpandedDescriptionJsonIdentifier: String?
    var indexPath: IndexPath?
    weak var delegate: LabelAndDescriptionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    @IBAction func navigateForwardPressed(_ sender: Any) {
        if let indexPathUnwrapped = indexPath {
            delegate?.navigateForwardPressed(indexPath: indexPathUnwrapped)
        }
    }
    
    func configure() {
        self.navigateForward.isHidden = requiresExpandedDescriptionJsonIdentifier == nil ? true : false
    }

}
