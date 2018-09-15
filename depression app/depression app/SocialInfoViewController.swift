//
//  SocialInfoViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

class SocialInfoViewController: UIViewController {

    @IBOutlet weak var childName: UITextField!
    @IBOutlet weak var socialHandle: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if x == 1 {
            socialHandle.placeholder = "Enter Twitter Username"
        }
        else if x == 2 {
            socialHandle.placeholder = "Enter Facebook Username"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
