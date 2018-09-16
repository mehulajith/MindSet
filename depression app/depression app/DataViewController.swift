//
//  DataViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit
import SwiftCharts

class DataViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let chart = Chart(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        let data: [Double] = [0, -2, -2, 3, -3, 4, 1, 0, -1]
        
        let series = ChartSeries(data)
        series.area = true
        
        chart.add(series)
        
        // Set minimum and maximum values for y-axis
        chart.minY = -7
        chart.maxY = 7
        
        // Format y-axis, e.g. with units
        chart.yLabelsFormatter = { String(Int($1)) +  "ºC" }
    }
        
        
}
