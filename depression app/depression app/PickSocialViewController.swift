//
//  PickSocialViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

class PickSocialViewController: UIViewController {
    
    
    @IBOutlet weak var twitterImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        twitterImage.layer.borderWidth=1.0
        twitterImage.layer.masksToBounds = false
        twitterImage.layer.borderColor = UIColor.white.cgColor;   twitterImage.layer.cornerRadius = 40
        twitterImage.clipsToBounds = true
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func twitterButton(_ sender: UIButton) {
        
    }

}
