//
//  DataViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit
import SwiftChart
import Alamofire

class DataViewController: UIViewController, ChartDelegate {
    
    @IBOutlet weak var chart: Chart!
    @IBOutlet weak var childsName: UILabel!
    @IBOutlet weak var analysis: UILabel!
    
    let session = URLSession.shared
    var googleAPIKey = "AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4"
    var googleURL: URL {
        return URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4")!
    }
    
    var indexScore: Double = 0.0
    var indexProfilePic: String = ""
    
    var scoreChartData:[Double] = []
    var selectedChart = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scoreChartData = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
        
        chart.delegate = self
        
        queryTwitter(user: UserDefaults.standard.string(forKey: "shortTermHandle")!, name: UserDefaults.standard.string(forKey: "shortTermName")!)
        
        let series = ChartSeries(scoreChartData)
        series.colors = (
            above: ChartColors.blueColor(),
            below: ChartColors.redColor(),
            zeroLevel: 0
        )
        series.area = true
        
        chart.add(series)
        
        // Set minimum and maximum values for y-axis
        chart.minY = -1
        chart.maxY = 1
        
        // Format y-axis, e.g. with units
        chart.yLabelsFormatter = { String(Int($1)) }
        
        childsName.text = UserDefaults.standard.string(forKey: "shortTermName")
        
    }
    
    func createGraph() {
        let series = ChartSeries(self.scoreChartData)
        series.colors = (
            above: ChartColors.blueColor(),
            below: ChartColors.redColor(),
            zeroLevel: 0
        )
        series.area = true
        
        chart.add(series)
        
        // Set minimum and maximum values for y-axis
        chart.minY = -1
        chart.maxY = 1
        
        // Format y-axis, e.g. with units
        chart.yLabelsFormatter = { String(Int($1)) }
    }
    
    func sortRawData(rawData: [String]) {
        scoreChartData.removeAll()
        for tweet in rawData {
            print(tweet)
            if tweet != "" {
                var temporary: Double
                createRequest(with: tweet)
                sleep(1)
                print(indexScore)
                scoreChartData.append(indexScore)
                print(scoreChartData)
                createGraph()
            }
        }
        
    var sum = scoreChartData.reduce(0, +)
    var avg = sum / Double(scoreChartData.count)
    var diag = ""
        
        if avg > 0.6 {
            diag = "\u{2022} Your child continues to smile 😊"
        }
        else if avg > 0.3 {
            diag = "\u{2022} You encourage your child to smile a bit more 👍 "
        }
        else if avg < 0.3 && avg > -0.3 {
            diag = "\u{2022} Your child gets more sleep 😴\n\u{2022} Spends less time on their phone📱"
        }
        else if avg > -0.6 {
            diag = "\u{2022} Your child strives for healthier relationships ♥️\n\u{2022}You spend more quality time with your child 🕑"
        }
        else if avg > -1.1 {
            diag = "\u{2022} Your child seek more help in order to elevate their emotional well-being 📈"
        }
        
        analysis.numberOfLines = 0;
        analysis.text = "According to the data, your child's emotional score is \(Float(avg)). We recommend that:\n \(diag)"
        
    }
    
    func queryTwitter(user: String, name: String) {
        let url = URL(string: "https://twitter.com/" + user)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    
                    if let errorMessage = error?.localizedDescription {
//                        print(errorMessage)
                    } else {
                        print("There is an error for some reason, check line 34")
                    }
                }
            } else {
                
                let webContent:String = String(data: data!, encoding: String.Encoding.utf8)!
                
                var array:[String] = webContent.components(separatedBy: "<title>")
                array.removeAll()
                
                array = webContent.components(separatedBy: "data-resolved-url-large=\"")
                array = array[1].components(separatedBy: "\"")
                let profilePicture = array[0] // GET PROFILE PICTURE OF THE NIB
                
                // GET MOST RECENT TWEET
                array = webContent.components(separatedBy: "data-aria-label-part=\"0\">")
                array.remove(at: 0)
                
                for i in 0 ... array.count-1 {
                    let newTweet = array[i].components(separatedBy: "<")
                    array[i] = newTweet[0]
                }
                
                self.sortRawData(rawData: array)
                
//                print(array)
            }
        }
        task.resume()
    }
    
    func createRequest(with text: String) {
        
        // Build our API request
        let object: [String:Any] = [
            "document": [
                "type": "PLAIN_TEXT",
                "content": text],
            "encodingType": "UTF8"
        ]
        
        Alamofire.request(googleURL, method: .post, parameters: object, encoding: JSONEncoding.default).responseJSON { data in
            //            print(data)
            
            if let status = data.response?.statusCode {
                switch(status){
                case 201: break
//                    print("example success")
                default: break
//                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            if let result = data.result.value {
                let JSON = result as! NSDictionary
                var jsonParsedData = JSON["documentSentiment"]! as! NSDictionary
                print(jsonParsedData)
                print(jsonParsedData["score"]!)
                let docScore = jsonParsedData["score"]!
                print(docScore)
                self.indexScore = docScore as! Double
            }
        }
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
