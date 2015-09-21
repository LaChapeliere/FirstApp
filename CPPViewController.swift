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
        activityIndicator.startAnimating()
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        let group = dispatch_group_create()
        dispatch_group_async(group, queue) {
            self.count = Useless_ObjCtoCPlusPlus.waitingFuncCPlusPlus(self.count)
        }
        dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
        activityIndicator.stopAnimating()
        label.text = "Congratulation, you have run \(count) C++ functions!"
    }
}
