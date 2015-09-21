//
//  UserLoggedViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 21/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class UserLoggedViewController: UIViewController, UITextFieldDelegate {

    var username: String!
    var userLogModel: UserLogModel!
    var data: [String]!
    
    var dataText: String {
        get {
            if data == nil {
                return ""
            }
            else {
                var text = ""
                for elem in data {
                    text += elem
                    text += ", "
                }
                if data.count > 0 {
                    text = dropLast(dropLast(text))
                }
                return text
            }
        }
    }

    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var dataField: UITextView!
    
    @IBOutlet weak var newDataField: UITextField!
    
    override func viewDidLoad() {
        if let text = welcomeLabel.text {
            welcomeLabel.text = text + username
        }
        if let datas = userLogModel.fetchData() {
            data = datas[username]
        }
        else {
            data = [String]()
        }
        dataField.text = dataText
        
        self.newDataField.delegate = self
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == newDataField {
            if let text = textField.text {
                if data != nil {
                    data! += [text]
                }
                else {
                    data = [text]
                }
                dataField.text = dataText
                newDataField.text = ""
                userLogModel.addData(username, data: [text])
            }
        }
        textField.resignFirstResponder()
        return true;
    }

}
