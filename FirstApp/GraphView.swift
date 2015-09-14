//
//  GraphView.swift
//  FirstApp
//
//  Created by Emma Barme on 14/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

@IBDesignable class GraphView: UIView {
    @IBInspectable var backgroundStartColor: UIColor = UIColor.greenColor()
    @IBInspectable var backgroundEndColor: UIColor = UIColor.grayColor()
    @IBInspectable var graphStartColor: UIColor = UIColor.greenColor()
    @IBInspectable var graphEndColor:UIColor = UIColor.grayColor()
    @IBInspectable var graphLineColor: UIColor = UIColor.whiteColor()
    
    var graphPoints = [Int]()
    let maxValue = 100 //To get adaptative maxValue, put it in the drawRect func and set it to maxElements(graphPoints)

    
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
        
        
        //If the data is empty or full of zeros, no drawing
        let topBorder: CGFloat = 50
        let bottomBorder: CGFloat = 50
        let margin: CGFloat = 20.0
        let graphHeight = height - topBorder - bottomBorder
        if graphPoints.count > 0 && maxElement(graphPoints) > 0 {
            if (graphPoints.count == 1)
            {
                graphPoints += graphPoints
            }
            
            //Add points
            var columnXPoint = { (column: Int) -> CGFloat in
                let spacer = (width - margin * 2 - 4) / CGFloat(max(self.graphPoints.count - 1, 1))
                var x: CGFloat = CGFloat(column) * spacer
                x += margin + 2
                return x
            }
            var columnYPoint = { (graphPoint: Int) -> CGFloat in
                var y: CGFloat = CGFloat(graphPoint) / CGFloat(self.maxValue) * graphHeight
                y = graphHeight + topBorder - y //Flip the graph
                return y
            }
            
            //Prepare the line
            graphLineColor.setFill()
            graphLineColor.setStroke()
            var graphPath = UIBezierPath()
            graphPath.moveToPoint(CGPoint(x: columnXPoint(0), y: columnYPoint(graphPoints[0])))
            for i in 1..<graphPoints.count {
                let nextPoint = CGPoint(x: columnXPoint(i), y: columnYPoint(graphPoints[i]))
                graphPath.addLineToPoint(nextPoint)
            }
            
            //Gradient graph
            CGContextSaveGState(context)
            var clippingPath = graphPath.copy() as! UIBezierPath //.copy because else it's a ref and is not copied
            clippingPath.addLineToPoint(CGPoint(x: columnXPoint(graphPoints.count - 1), y: height))
            clippingPath.addLineToPoint(CGPoint(x: columnXPoint(0), y: height))
            clippingPath.closePath()
            clippingPath.addClip()
            let highestGraphPoint = columnYPoint(maxValue)
            var graphGradientStartPoint = CGPoint(x: 0, y: highestGraphPoint)
            var graphGradientEndPoint = CGPoint(x: 0, y: self.bounds.height)
            let graphColors = [graphStartColor.CGColor, graphEndColor.CGColor]
            let graphGradient = CGGradientCreateWithColors(colorSpace, graphColors, colorLocation)
            let rectPath = UIBezierPath(rect: self.bounds)
            CGContextDrawLinearGradient(context, graphGradient, graphGradientStartPoint, graphGradientEndPoint, 0)
            CGContextRestoreGState(context)
            //End of gradient graph (Comment this section for a simple lign graph)
            
            //Draw the line
            graphPath.lineWidth = 2.0
            graphPath.stroke()
        }
        
        
        //Adding 5 horizontal lines
        //////////////////// This code should be refactored!! //////////////////
        var horizontalLinePath = UIBezierPath()
        //Setting properties for the labels
        let textAttributes: [String: AnyObject] = [
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont.systemFontOfSize(17)
        ]
        let textShift:CGFloat = 5.0
        //top line
        let labelY1: NSString = "\(maxValue)"
        horizontalLinePath.moveToPoint(CGPoint(x:margin, y: topBorder))
        horizontalLinePath.addLineToPoint(CGPoint(x: width - margin,
            y: topBorder))
        labelY1.drawAtPoint(CGPoint(x: margin + textShift,
            y: topBorder), withAttributes: textAttributes)
        //...
        let labelY2: NSString = "\(maxValue / 4)" //Label inversés car zéro en haut
        horizontalLinePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/4 * 3 + topBorder))
        horizontalLinePath.addLineToPoint(CGPoint(x:width - margin,
            y: graphHeight/4 * 3 + topBorder))
        labelY2.drawAtPoint(CGPoint(x: margin + textShift,
            y: graphHeight/4 * 3 + topBorder), withAttributes: textAttributes)
        //...
        let labelY3: NSString = "\(maxValue / 2)"
        horizontalLinePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/2 + topBorder))
        horizontalLinePath.addLineToPoint(CGPoint(x:width - margin,
            y: graphHeight/2 + topBorder))
        labelY3.drawAtPoint(CGPoint(x: margin + textShift,
            y: graphHeight/2 + topBorder), withAttributes: textAttributes)
        //...
        let labelY4: NSString = "\(maxValue / 4 * 3)"
        horizontalLinePath.moveToPoint(CGPoint(x:margin,
            y: graphHeight/4 + topBorder))
        horizontalLinePath.addLineToPoint(CGPoint(x:width - margin,
            y: graphHeight/4 + topBorder))
        labelY4.drawAtPoint(CGPoint(x: margin + textShift,
            y: graphHeight/4 + topBorder), withAttributes: textAttributes)
        //...
        let labelY5: NSString = "\(0)"
        horizontalLinePath.moveToPoint(CGPoint(x:margin,
            y: height - bottomBorder))
        horizontalLinePath.addLineToPoint(CGPoint(x:width - margin,
            y: height - bottomBorder))
        labelY5.drawAtPoint(CGPoint(x: margin + textShift,
            y: height - bottomBorder), withAttributes: textAttributes)
        let color = UIColor(white: 1.0, alpha: 0.3) //Semi transparent white lines
        color.setStroke()
        horizontalLinePath.lineWidth = 1.0
        horizontalLinePath.stroke()
        //////////////////////////////////////////////////////////////////////////
    }
}
