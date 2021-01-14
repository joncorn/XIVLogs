//
//  BarChartTestViewController.swift
//  XIVLogs
//
//  Created by Jon Corn on 1/13/21.
//

import UIKit

class BarChartTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        BarChartView.dataEntries =
           [
              BarEntry(score: 45, title: "Stark"),
              BarEntry(score: 35, title: "Thor"),
              BarEntry(score: 55, title: "Evans"),
              BarEntry(score: 3, title: "Vision"),
              BarEntry(score: 10, title: "Thanos")
           ]
        view.addSubview(BarChartView)
        // Do any additional setup after loading the view.
    }
    
    
    lazy var BarChartView: barChartView = {
          let BarChartViewTest = barChartView()
          BarChartViewTest.frame = view.frame
          return BarChartViewTest
       }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
