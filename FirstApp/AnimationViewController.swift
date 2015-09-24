//
//  AnimationViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 23/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {
    
    var dropSize: CGSize {
        let dropDiameter = NSUserDefaults.standardUserDefaults().doubleForKey("AnimationViewController.dropDiameter")
        return CGSize(width: dropDiameter, height: dropDiameter)
    }
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedAnimator = UIDynamicAnimator(referenceView: self.view)
        return lazilyCreatedAnimator
    } ()
    
    let dropBehavior = DropBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animator.addBehavior(dropBehavior)
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    @IBAction func swipe(sender: UISwipeGestureRecognizer) {
        dropBehavior.changeGravity(sender.direction)
    }
    
    @IBAction func clear(sender: UILongPressGestureRecognizer) {
        clear()
    }

    func drop () {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(min: CGPointZero.x, max: view.bounds.size.width)
        frame.origin.y = CGFloat.random(min: CGPointZero.y, max: view.bounds.size.height)
        
        let dropView = DropView(frame: frame)
        dropView.layer.cornerRadius = dropView.frame.size.width / 2;
        dropView.clipsToBounds = true;

        
        dropBehavior.addDrop(dropView)
    }
    
    func clear () {
        //Remove with animation all drops of a random color
        var color: UIColor?
        for subview in self.view.subviews {
            if let drop = subview as? DropView {
                if color == nil {
                    color = drop.color
                }
                if (color == drop.color)
                {
                    if drop.alpha == 1.0 {
                        UIView.animateWithDuration(3, animations: {
                            drop.alpha = 0.0
                            }) { if $0 {self.dropBehavior.removeDrop(drop)} }
                    }
                }
            }
        }
    }
    

}

private extension CGFloat {
    /**
    Returns a random floating point number between 0.0 and 1.0, inclusive.
    By DaRkDOG
    */
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    /**
    Create a random num CGFloat
    :param: lower number CGFloat
    :param: upper number CGFloat
    :return: random number CGFloat
    By DaRkDOG
    */
    static func random(#min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random() * (max - min) + min
    }
}