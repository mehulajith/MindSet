//
//  SocialInfoViewController.swift
//  depression app
//
//  Created by Mohamed Maazin Sudheer on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import TextFieldEffects

class SocialInfoViewController: UIViewController {

    @IBOutlet weak var childName: UITextField!
    @IBOutlet weak var socialHandle: UITextField!
    @IBOutlet weak var button: UIButton!
    
    let session = URLSession.shared
    var googleAPIKey = "AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4"
    var googleURL: URL {
        return URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4")!
    }
    var currentEmoji = "😐"
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if x == 1 {
            socialHandle.placeholder = "Enter Twitter Username"
        }
        else if x == 2 {
            socialHandle.placeholder = "Enter Facebook Profile Link"
        }
        
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 7)
        button.layer.shadowRadius = 10
        button.layer.shadowOpacity = 0.5
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
            sleep(2)
            performSegue(withIdentifier: "createNibProfile", sender: self)
        }
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
                case 201:
                    print("example success")
                default:
                    print("error with response status: \(status)")
                }
            }
            //to get JSON return value
            if let result = data.result.value {
                let JSON = result as! NSDictionary
                var jsonParsedData = JSON["documentSentiment"]! as! NSDictionary
                print(jsonParsedData["magnitude"]!)
                let docScore = jsonParsedData["magnitude"]! as! Double
                
                self.emojiSelection(score: docScore)
            }
        }
    }
    
    func emojiSelection(score: Double) {
        if score > 0.6 {
            currentEmoji = "😀"
        } else if score > 0.3 {
            currentEmoji = "🙂"
        } else if score <= 0.3 && score > -0.3 {
            currentEmoji = "😐"
        } else if score > -0.6 {
            currentEmoji = "🙁"
        } else if score > -1.1 {
            currentEmoji = "😨"
        }
    }

    // QUERY TWITTER FOR DATA ABOUT THE NIB
    func queryTwitter(user: String, name: String) {
        let url = URL(string: "https://twitter.com/" + user)
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                self.index = 0
                DispatchQueue.main.async {
                    
                    if let errorMessage = error?.localizedDescription {
                        print(errorMessage)
                    } else {
                        print("There is an error for some reason, check line 34")
                    }
                }
            } else {
                self.index = 1
                
                let webContent:String = String(data: data!, encoding: String.Encoding.utf8)!
                
                var array:[String] = webContent.components(separatedBy: "<title>")
                array = array[1].components(separatedBy: " |")
                let name = array[0] // GET NAME OF THE USERNAME
                array.removeAll()
                
                array = webContent.components(separatedBy: "data-resolved-url-large=\"")
                array = array[1].components(separatedBy: "\"")
                let profilePicture = array[0] // GET PROFILE PICTURE OF THE NIB
                
                array = webContent.components(separatedBy: "data-aria-label-part=\"0\">")
                array.remove(at: 0)
                
                // GET MOST RECENT TWEET
                array = webContent.components(separatedBy: "data-aria-label-part=\"0\">")
                array.remove(at: 0)
                
                for i in 0 ... array.count-1 {
                    let newTweet = array[i].components(separatedBy: "<")
                    array[i] = newTweet[0]
                }
                
                let body = array[0]
                
                self.createRequest(with: body)
                
                sleep(2)
                
                /*for i in 0...array.count - 1 {
                    let newTweet = array[i].components(separatedBy: "<")
                    array[i] = newTweet[0]
                }*/
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(self.childName.text, forKey: "newName")
                    UserDefaults.standard.set(profilePicture, forKey: "newProfilePicture")
                    UserDefaults.standard.set("@" + self.socialHandle.text!, forKey: "newHandle")
                    UserDefaults.standard.set(self.currentEmoji, forKey: "newEmoji")
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
