//
//  CPPViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 21/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class CPPViewController: UIViewController {
    
    var count = 0

    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func goAction() {
        self.activityIndicator.startAnimating()
        let qos = Int(QOS_CLASS_USER_INITIATED.value)
        
        dispatch_async(dispatch_get_global_queue(Int(QOS_CLASS_USER_INITIATED.value), 0)) { () -> Void in
            self.count = Useless_ObjCtoCPlusPlus.waitingFuncCPlusPlus(self.count)
            
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.activityIndicator.stopAnimating()
                self.label.text = "Congratulation, you have run \(self.count) C++ function(s)!"
            }
        }
    }
}
