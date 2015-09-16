//
//  GraphLineChartViewContainer.swift
//  FirstApp
//
//  Created by Emma Barme on 16/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class GraphLineChartViewContainer: UIView {
    
    @IBInspectable var backgroundStartColor: UIColor = UIColor.greenColor()
    @IBInspectable var backgroundEndColor: UIColor = UIColor.grayColor()

    override func drawRect(rect: CGRect) {
        let width = rect.width
        let height = rect.height
        
        //Draw gradient for background
        let context = UIGraphicsGetCurrentContext()
        let backgroundColors = [backgroundStartColor.CGColor, backgroundEndColor.CGColor]
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let colorLocation: [CGFloat] = [0.0, 1.0]
        let backgroundGradient = CGGradientCreateWithColors(colorSpace, backgroundColors, colorLocation)
        var backgroundGradientStartPoint = CGPoint.zeroPoint
        var backgroundGradientEndPoint = CGPoint(x: 0, y: self.bounds.height)
        CGContextDrawLinearGradient(context, backgroundGradient, backgroundGradientStartPoint, backgroundGradientEndPoint, 0)
    }

}
