//
//  LogViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 16/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class LogViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!

    @IBOutlet weak var passwordField: UITextField!
    
    let userLogModel = UserLogModel()
    
    @IBAction func actionButtons(sender: UIButton) {
        let actionDescription = sender.titleLabel?.text
        switch actionDescription! {
        case "Log In":
            let log = userLogModel.logInUser(usernameField.text, password: passwordField.text)
            if log == nil {
                performSegueWithIdentifier("logInSegue", sender: self)
            }
            else {
                let alertUsernameAlreadyRegistered = UIAlertController(title: "Error",
                    message: log,
                    preferredStyle: .Alert)
                alertUsernameAlreadyRegistered.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alertUsernameAlreadyRegistered, animated: true, completion: nil)
            }
        case "Register":
            let addedUser = userLogModel.addUser(usernameField.text, password: passwordField.text)
            if addedUser {
                performSegueWithIdentifier("logInSegue", sender: self)
            }
            else {
                let alertUsernameAlreadyRegistered = UIAlertController(title: "Error",
                    message: "This username is already registered.",
                    preferredStyle: .Alert)
                alertUsernameAlreadyRegistered.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                presentViewController(alertUsernameAlreadyRegistered, animated: true, completion: nil)
            }
        case "Clear fields":
            usernameField.text = nil
            passwordField.text = nil
        default:
            break
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "logInSegue" {
            if let destination = segue.destinationViewController as? UserLoggedViewController {
                destination.username = usernameField.text
                destination.userLogModel = userLogModel
            }
        }
    }
}
