//
//  ViewController.swift
//  depression app
//
//  Created by Mehul Ajith on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let twitterHandle = "the_blackshirt"

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func searchUser(_ sender: UIButton) {
        let user = twitterHandle.replacingOccurrences(of: " ", with: "")
        //queryTwitter(user: user)
    }
    
    func queryTwitter(user: String) {
        let url = URL(string: "https://twitter.com/" + user)

        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {

                    if let errorMessage = error?.localizedDescription {
                        print(errorMessage)
                    } else {
                        print("There is an error for some reason, check line 34")
                    }
                }
            } else {
                
            }
        }
        task.resume()
    }
    
    func updateImage(url:String) {
        let url = URL(string: url)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            DispatchQueue.main.async {
                // self.myImageView.image = UIImage(data: data!)
            }
        }
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

