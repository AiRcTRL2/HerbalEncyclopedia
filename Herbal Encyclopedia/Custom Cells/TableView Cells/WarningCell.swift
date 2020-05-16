//
//  WarningCell.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

class WarningCell: UITableViewCell {
    @IBOutlet weak var warningLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configure(warnings: [String]) {
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.headIndent = 20

        let text = NSMutableAttributedString()
        
        
        for warning in warnings {
            let warningText = NSMutableAttributedString(string: "\u{2022} \(warning)\n", attributes: [NSAttributedString.Key.paragraphStyle: style,NSAttributedString.Key.foregroundColor:UIColor.blue])
            text.append(warningText)
        }

        warningLabel.attributedText = text
    }
}
