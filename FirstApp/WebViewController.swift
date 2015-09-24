//
//  WebViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 24/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {

    @IBOutlet weak var urlField: UITextField!
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func accessURL() {
        let url = NSURL(string: urlField.text)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            if error == nil {
                var htmlString = NSString(data: data, encoding: NSUTF8StringEncoding)
                println(htmlString)
                if (htmlString != nil)
                {
                    self.webView.loadHTMLString(htmlString as! String, baseURL: nil)
                }
            }
        }
        
        task.resume()
    }
}
