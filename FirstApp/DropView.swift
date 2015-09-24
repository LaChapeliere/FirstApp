//
//  DropView.swift
//  FirstApp
//
//  Created by Emma Barme on 23/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class DropView: UIView {
    
    let color = UIColor.random()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        color.setFill()
        path.fill()
    }
}

private extension UIColor {
    static func random() -> UIColor {
        switch arc4random() % 5 {
        case 1:
            return UIColor.blackColor()
        case 2:
            return UIColor.purpleColor()
        case 3:
            return UIColor.orangeColor()
        case 4:
            return UIColor.whiteColor()
        default:
            return UIColor.magentaColor()
        }
    }
}