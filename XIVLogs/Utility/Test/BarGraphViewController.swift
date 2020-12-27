//
//  BarGraphViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 12/25/20.
//

import UIKit
import SwiftCharts

class BarGraphViewController: UIViewController {
    
    //  MARK: - Properties
    
    var chartView: BarsChart!
    
    //  MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //  MARK: - BarChart video
    
    let chartConfig = BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 800, by: 100))
    
    let frame = CGRect(x: 0, y: 270, width: 500, height: 450)
    
    let chart = BarsChart(frame: CGRect(x: 0, y: 270, width: 500, height: 450), chartConfig: BarsChartConfig(valsAxisConfig: ChartAxisConfig(from: 0, to: 800, by: 100)), xTitle: "months", yTitle: "Units Sold", bars: [("Jan", 120), ("Feb", 400.5), ("Mar", 100), ("Apr", 500.4)], color: UIColor.darkGray, barWidth: 15)
    
    
    
    //  MARK: - Methods
    
}
