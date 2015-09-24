//
//  DropBehavior.swift
//  FirstApp
//
//  Created by Emma Barme on 23/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class DropBehavior: UIDynamicBehavior {
   
    let gravity = UIGravityBehavior()
    
    lazy var collider: UICollisionBehavior = {
        let lazilyCreatedCollider = UICollisionBehavior()
        lazilyCreatedCollider.translatesReferenceBoundsIntoBoundary = true
        return lazilyCreatedCollider
    } ()
    
    lazy var singleDropBehavior: UIDynamicItemBehavior = {
        let lazilyCreatedSingleDropBehavior = UIDynamicItemBehavior()
        lazilyCreatedSingleDropBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("DropBehavior.dropBounciness"))
        NSNotificationCenter.defaultCenter().addObserverForName(NSUserDefaultsDidChangeNotification, object: nil, queue: nil) { (notification) -> Void in
            lazilyCreatedSingleDropBehavior.elasticity = CGFloat(NSUserDefaults.standardUserDefaults().doubleForKey("DropBehavior.dropBounciness"))
        }
        return lazilyCreatedSingleDropBehavior
    } ()
    
    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(singleDropBehavior)
    }
    
    func addDrop (drop: DropView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        singleDropBehavior.addItem(drop)
    }
    
    func removeDrop (drop: DropView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        singleDropBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
    
    func changeGravity(direction: UISwipeGestureRecognizerDirection) {
        var newGravityDirection: CGVector!
        switch direction {
        case UISwipeGestureRecognizerDirection.Left:
            newGravityDirection = CGVector(dx: -1, dy: 0)
        case UISwipeGestureRecognizerDirection.Right:
            newGravityDirection = CGVector(dx: 1, dy: 0)
        case UISwipeGestureRecognizerDirection.Up:
            newGravityDirection = CGVector(dx: 0, dy: -1)
        case UISwipeGestureRecognizerDirection.Down:
            newGravityDirection = CGVector(dx: 0, dy: 1)
        default:
            break
        }
        gravity.gravityDirection = newGravityDirection
    }
}
