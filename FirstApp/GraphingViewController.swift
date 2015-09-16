//
//  GraphigViewController.swift
//  FirstApp
//
//  Created by Emma Barme on 11/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit
import Charts

class GraphingViewController: UIViewController {
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var graphView: GraphView!
    
    @IBOutlet weak var chartViewContainer: GraphLineChartViewContainer!
    
    @IBOutlet weak var chartView: GraphLineChartView!
    
    var graphingModel = GraphingModel()
    
    override func viewDidLoad() {
        setChartViewProperties()
    }
    
    @IBAction func changeValueSlider(sender: UISlider) {
        label.text = "\(Int(slider.value))"
    }
    
    @IBAction func pushValue() {
        graphingModel.addValue(Int(slider.value))
        if (graphView.hidden == false)
        {
            graphView.graphPoints = graphingModel.accessRawData()
            graphView.setNeedsDisplay()
        }
        else if (chartView.hidden == false)
        {
            setChartView()
        }
        
    }
    
    //Redraw graph when rotate
    override func viewDidLayoutSubviews() {
        graphView.setNeedsDisplay()
    }
    
    @IBAction func graphTypeSelection(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            chartViewContainer.hidden = true
            graphView.hidden = false
            graphView.graphPoints = graphingModel.accessRawData()
            graphView.setNeedsDisplay()
        case 1:
            chartViewContainer.hidden = false
            graphView.hidden = true
            setChartView()
        default:
            break;
        }
    }
    
    func setChartView () {
        let data = graphingModel.accessRawData()
        var xLabels = [String]()
        var values = [Double]()
        for i in 0..<data.count {
            xLabels.append("")
            values.append(Double(data[i]))
        }
        let chartData = chartView.setChart(xLabels, values: values)
        chartView.data = chartData
    }
    
    func setChartViewProperties () {
        //Set chartView properties
        chartViewContainer.hidden = true
        chartView.noDataText = "" //Delete the yellow info message that says the data is empty
        chartView.backgroundColor = UIColor.clearColor()
        chartView.drawGridBackgroundEnabled = false //Delete the ugly grey background
        
        //Axis
        chartView.xAxis.labelPosition = .Bottom
        chartView.xAxis.axisLineWidth *= 4
        chartView.xAxis.axisLineColor = chartView.axisColor
        chartView.getAxis(ChartYAxis.AxisDependency.Left).axisLineWidth *= 4
        chartView.getAxis(ChartYAxis.AxisDependency.Left).axisLineColor = chartView.axisColor
        chartView.getAxis(ChartYAxis.AxisDependency.Left).labelTextColor = chartView.axisColor
        chartView.getAxis(ChartYAxis.AxisDependency.Left).labelFont = UIFont.systemFontOfSize(16.0)
        chartView.getAxis(ChartYAxis.AxisDependency.Right).axisLineWidth *= 4
        chartView.getAxis(ChartYAxis.AxisDependency.Right).axisLineColor = chartView.axisColor
        chartView.getAxis(ChartYAxis.AxisDependency.Right).drawLabelsEnabled = false
        //No grid lines
        chartView.xAxis.drawGridLinesEnabled = false
        chartView.getAxis(ChartYAxis.AxisDependency.Right).drawGridLinesEnabled = false
        chartView.getAxis(ChartYAxis.AxisDependency.Left).drawGridLinesEnabled = false
        
        //Legends
        chartView.legend.setCustom(colors: [UIColor?](), labels: [String?]()) //No legend
        chartView.descriptionText = "" //No description text at the bottom right
    }
}