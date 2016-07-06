//
//  BarChartViewController.swift
//  iOSChartsDemo
//
//  Created by Joyce Echessa on 6/12/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//

import UIKit
import Charts

class BarChartViewController: UIViewController {
    var months: [String]!

    @IBOutlet weak var barChartView: BarChartView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
        let unitsSold = [20.0, 4.0, 6.0, 3.0, 12.0, 16.0, 4.0, 18.0, 2.0, 4.0, 5.0, 4.0]
        
        setChart(months, values: unitsSold)
        
    }

    func setChart(dataPoints: [String], values: [Double]){
        barChartView.noDataText = "You need to provide data for the chart"
        barChartView.noDataTextDescription = "GIVE REASON"
        
        var dataEntries: [BarChartDataEntry] = []
        for i in 0..<values.count {
            let dataEntry = BarChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(yVals: dataEntries, label: "Units Sold")
        let chartData = BarChartData(xVals: months, dataSet: chartDataSet)
        
        barChartView.data = chartData
        
        barChartView.descriptionText = ""
//        barChartView.pinchZoomEnabled = false
        barChartView.doubleTapToZoomEnabled = false
        chartDataSet.colors = [UIColor.greenColor(), UIColor.redColor()]
        barChartView.xAxis.labelPosition = .Bottom
        barChartView.backgroundColor = UIColor(red: 189/255, green: 195/255, blue: 199/255, alpha: 1)
        barChartView.animate(xAxisDuration: 1, yAxisDuration: 1)
        
        let ll = ChartLimitLine(limit: 11, label: "Target")
        barChartView.rightAxis.addLimitLine(ll)
    }
    
    @IBAction func saveChart(sender: AnyObject) {
        barChartView.saveToCameraRoll()
    }
}

