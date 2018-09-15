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
    
    @IBAction func addInfo(_ sender: UIButton) {
        if (childName.text != "" && socialHandle.text != "") {
            let childName = self.childName.text?.replacingOccurrences(of: " ", with: "")
            let socialHandle = self.socialHandle.text?.replacingOccurrences(of: " ", with: "")
            queryTwitter(user: socialHandle!, name: childName!)
        }
    }
    
    // QUERY TWITTER FOR DATA ABOUT THE NIB
    func queryTwitter(user: String, name: String) {
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
                let webContent:String = String(data: data!, encoding: String.Encoding.utf8)!
                
                var array:[String] = webContent.components(separatedBy: "<title>")
                array = array[1].components(separatedBy: " )")
                let name = array[0] // GET NAME OF THE NIB
                array.removeAll()
                
                array = webContent.components(separatedBy: "data-resolved-url-large=\"")
                array = array[1].components(separatedBy: "\"")
                let profilePicture = array[0] // GET PROFILE PICTURE OF THE NIB
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(name, forKey: "newName")
                    UserDefaults.standard.set(profilePicture, forKey: "newProfilePicture")
                }
            }
        }
        task.resume()
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
