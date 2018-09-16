//
//  DataViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit
import SwiftChart

class DataViewController: UIViewController, ChartDelegate {
    
    @IBOutlet weak var chart: Chart!
    
    var selectedChart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chart.delegate = self
        
        let data: [Double] = [0, -2, -2, 3, -3, 4, 1, 0, -1]
        let series = ChartSeries(data)
        series.colors = (
            above: ChartColors.blueColor(),
            below: ChartColors.redColor(),
            zeroLevel: -1
        )
        series.area = true
        
        chart.add(series)
        
        // Set minimum and maximum values for y-axis
        chart.minY = -7
        chart.maxY = 7
        
        // Format y-axis, e.g. with units
        chart.yLabelsFormatter = { String(Int($1)) +  "ºC" }
        
    }
    
    func didTouchChart(_ chart: Chart, indexes: Array<Int?>, x: Double, left: CGFloat) {
        for (seriesIndex, dataIndex) in indexes.enumerated() {
            if let value = chart.valueForSeries(seriesIndex, atIndex: dataIndex) {
                print("Touched series: \(seriesIndex): data index: \(dataIndex!); series value: \(value); x-axis value: \(x) (from left: \(left))")
            }
        }
    }
    
    func didFinishTouchingChart(_ chart: Chart) {
        
    }
    
    func didEndTouchingChart(_ chart: Chart) {
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        
        // Redraw chart on rotation
        chart.setNeedsDisplay()
    }
        
        
}
