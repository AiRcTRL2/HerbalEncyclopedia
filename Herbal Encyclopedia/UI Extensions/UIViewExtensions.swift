//
//  UIViewExtensions.swift
//  Herbal Encyclopedia
//
//  Created by Karim Elgendy on 16/05/2020.
//  Copyright © 2020 Rebellion Media. All rights reserved.
//

import UIKit

enum ViewSide {
    case Left, Right, Top, Bottom, FullScreenWidthBottom, FullScreenWidthTop
}

extension UIView {
    // source: https://stackoverflow.com/questions/53908783/border-bottom-in-uiview-swift-4


    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat, offsetX: CGFloat = 0, offsetY: CGFloat = 0) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
            break
        case .Right:
            border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
            break
        case .Top:
            border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
            break
        case .Bottom:
            border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
            break
        case .FullScreenWidthBottom:
            var multiplier: CGFloat = 1.0
            print(frame.size.height)
            switch frame.size.height {
            case 80..<100:
                multiplier = 1.2
            default:
                break
            }

            border.frame = CGRect(x: 0+offsetX, y: frame.size.height+offsetY*multiplier, width: UIScreen.main.bounds.width, height: thickness)
            
        case .FullScreenWidthTop:
                border.frame = CGRect(x: 0+offsetX, y: 0, width: UIScreen.main.bounds.width, height: thickness)
        }


        layer.addSublayer(border)
    }
    
    func bulletPointAttributedString(stringList: [String]) -> NSMutableAttributedString {
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
