//
//  GraphigViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 11/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit

class GraphingViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var graphView: GraphView!
    
    var graphingModel = GraphingModel()
    
    @IBAction func changeValueSlider(sender: UISlider) {
        label.text = "\(Int(slider.value))"
    }
    
    @IBAction func pushValue() {
        graphingModel.addValue(Int(slider.value))
        graphView.graphPoints = graphingModel.accessRawData()
        graphView.setNeedsDisplay()
    }
    
}