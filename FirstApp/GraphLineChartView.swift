//
//  GraphLineChartView.swift
//  FirstApp
//
//  Created by Emma Barme on 15/09/2015.
//  Copyright (c) 2015 Emma Barme. All rights reserved.
//

import UIKit
import Charts

@IBDesignable class GraphLineChartView: LineChartView {

    @IBInspectable var lineColor: UIColor = UIColor.blackColor()
    @IBInspectable var axisColor: UIColor = UIColor.greenColor()
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    func setChart(dataPoints: [String], values: [Double]) -> LineChartData
    {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let lineChartDataSet = LineChartDataSet(yVals: dataEntries, label: "Your values")
        lineChartDataSet.colors = [lineColor]
        lineChartDataSet.circleColors = [lineColor]
        lineChartDataSet.circleHoleColor = axisColor
        lineChartDataSet.drawValuesEnabled = false //Disable values on points
        let lineChartData = LineChartData(xVals: dataPoints, dataSet: lineChartDataSet)
        return lineChartData
    }
}
