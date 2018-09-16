//
//  PickSocialViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

var x = 0

class PickSocialViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        twitterImage.layer.borderWidth = 1.0
//        twitterImage.layer.masksToBounds = false
//        twitterImage.layer.borderColor = UIColor.white.cgColor;
//        twitterImage.layer.cornerRadius = 50
//        twitterImage.clipsToBounds = true
//
//        fbImage.layer.borderWidth=1.0
//        fbImage.layer.masksToBounds = false
//        fbImage.layer.borderColor = UIColor.white.cgColor;
//        fbImage.layer.cornerRadius = 50
//        fbImage.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
       
        x = 1
        
    }
    
    
    @IBAction func fbButton(_ sender: UIButton) {
        
        x = 2
        
    }
    
}
