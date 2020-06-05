//
//  LabelAndDescriptionCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 28/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import Foundation
import UIKit

class LabelAndDescriptionCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleString: String = ""
    var descriptionOrDescList: [Any]? = []
    var requiresExpandedDescriptionJsonIdentifier: String?

}
