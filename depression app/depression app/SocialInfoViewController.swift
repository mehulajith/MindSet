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

class SocialInfoViewController: UIViewController {

    @IBOutlet weak var childName: UITextField!
    @IBOutlet weak var socialHandle: UITextField!
    
    let session = URLSession.shared
    var googleAPIKey = "AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4"
    var googleURL: URL {
        return URL(string: "https://language.googleapis.com/v1/documents:analyzeSentiment?key=AIzaSyBJwil2ZNsxAjLon0pHXaLxTkzBOFv_gL4")!
    }
    
    var index = 0
    
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
            sleep(2)
            performSegue(withIdentifier: "createNibProfile", sender: self)
        }
    }
        
    func createRequest(with text: String) {
        // Create our request URL
        
       
//
//        var request = URLRequest(url: googleURL)
//        request.httpMethod = "POST"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.addValue(Bundle.main.bundleIdentifier ?? "", forHTTPHeaderField: "X-Ios-Bundle-Identifier")
        
            // Build our API request
        let object: [String:Any] = [
            "document": [
                "type": "PLAIN_TEXT",
                "content": text],
            "encodingType": "UTF8"
        ]
        
        Alamofire.request(googleURL, method: .post, parameters: object, encoding: JSONEncoding.default).responseJSON { json in
            print(json)
        }
        
//        let json = try? JSONSerialization.data(withJSONObject: object, options: .prettyPrinted)
//
////        let json = JSON(jsonDictionary: object)
////        let jsonObject = JSONSerialization.jsonObject(with: jsonRequest, options: []) as? [String : Any]
//
//        // Serialize the JSON
//
//        guard let data = json else {
//            // the json serialization failed
//        }
//
//        request.httpBody = data
//
//        // Run the request on a background thread
//        NSURLConnection.sendAsynchronousRequest(request, queue: OperationQueue.main) {(response, data, error) in
//            guard let data = data else { return }
//            print(String(data: data, encoding: .utf8)!)
//        }
//        DispatchQueue.global().async { self.runRequestOnBackgroundThread(request, handler: { (result) in
//            handler(result)
//        }) }
//
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
                
                
                /*for i in 0...array.count - 1 {
                    let newTweet = array[i].components(separatedBy: "<")
                    array[i] = newTweet[0]
                }*/
                
                DispatchQueue.main.async {
                    UserDefaults.standard.set(self.childName.text, forKey: "newName")
                    UserDefaults.standard.set(profilePicture, forKey: "newProfilePicture")
                    UserDefaults.standard.set("@" + self.socialHandle.text!, forKey: "newHandle")
                    UserDefaults.standard.set("😑", forKey: "newEmoji")
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
