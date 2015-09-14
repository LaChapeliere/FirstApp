//
//  PushButtonView.swift
//  FirstApp
//
//  Created by Emma Barme on 14/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

@IBDesignable class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.blueColor()
    
    override func drawRect(rect: CGRect) {
        //draw the circle
        var path = UIBezierPath(ovalInRect: rect)
        fillColor.setFill()
        path.fill()
        
        //set up the width and height variables
        let plusHeight: CGFloat = 4.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
        //create the path
        var plusPath = UIBezierPath()
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2,
            y:bounds.height/2))
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2,
            y:bounds.height/2))
        //move the initial point of the path
        //to the start of the vertical stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 - plusWidth/2))
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2,
            y:bounds.height/2 + plusWidth/2))
        //set the stroke color
        UIColor.whiteColor().setStroke()
        //draw the stroke
        plusPath.stroke()
    }

}
