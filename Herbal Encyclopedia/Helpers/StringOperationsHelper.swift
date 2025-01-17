//
//  ViewControllerExtensions.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

struct StringOperationsHelper {
    static func bulletPoints(stringList: [String]?) -> NSMutableAttributedString? {
        guard let stringList = stringList else {
            return nil
        }
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        style.headIndent = 13
        style.lineSpacing = 3

        let mainString = NSMutableAttributedString()
        
        if stringList.count > 1 {
            for string in stringList {
                let bulletPoint = NSMutableAttributedString(string: "\u{2022}   ", attributes: [NSAttributedString.Key.paragraphStyle: style, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)])
                bulletPoint.append(NSAttributedString(string: (string), attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .light)]))
                if string != stringList.last {
                    bulletPoint.append(NSMutableAttributedString(string: "\n"))
                }
                mainString.append(bulletPoint)
            }
        } else if stringList.count == 1 {
            mainString.append(NSAttributedString(string: stringList[0]))
        }
        
    
        return mainString
    }
}
