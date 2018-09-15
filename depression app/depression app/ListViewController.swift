//
//  ListViewController.swift
//  depression app
//
//  Created by Mehul Ajith on 9/15/18.
//  Copyright © 2018 Mehul Ajith. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var childrenName:[String] = ["Vines Janarthanan"]
    var childrenHandle:[String] = ["@vines"]
    var childrenEmoji:[String] = ["😀"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.string(forKey: "newName") != nil {
            childrenName.append(UserDefaults.standard.string(forKey: "newName")!)
            childrenEmoji.append(UserDefaults.standard.string(forKey: "newEmoji")!)
            childrenHandle.append(UserDefaults.standard.string(forKey: "newHandle")!)
            print(childrenEmoji)
            print(childrenHandle)
            print(childrenName)
            UserDefaults.standard.removeObject(forKey: "newName")
            UserDefaults.standard.removeObject(forKey: "newEmoji")
            UserDefaults.standard.removeObject(forKey: "newHandle")
            self.tableView.reloadData()
        } else {
            print("L")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.name.text = childrenName[indexPath.row]
        cell.handle.text = childrenHandle[indexPath.row]
        cell.emoji.text = childrenEmoji[indexPath.row]
        
        return cell
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
