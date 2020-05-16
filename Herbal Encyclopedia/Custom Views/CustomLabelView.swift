//
//  CustomLabelView.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 08/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

@IBDesignable
class CustomLabelView: UILabel {
    @IBInspectable
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = self.frame.size.width/2
            self.layer.masksToBounds = true
        }
        get {
            return self.layer.cornerRadius
        }
    }
    
    @IBInspectable
    var preferredLayoutWidth: CGFloat {
        set {
            self.preferredMaxLayoutWidth = newValue
        }
        get {
            return self.preferredMaxLayoutWidth
        }
    }
}
