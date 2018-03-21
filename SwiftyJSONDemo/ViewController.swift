//
//  ViewController.swift
//  SwiftyJSONDemo
//
//  Created by Appinventiv on 21/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var results = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = true
        tableView.separatorColor = .clear
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func searchButton(_ sender: UIButton) {
        let typedText : String? = searchTextField.text!
        if typedText?.isEmpty == true{
            print("invalid search")
        }
        else{
            JSONParser().parser(searchText: typedText!, success: { (dataModel) in
                self.results = dataModel
                self.tableView.reloadData()
                self.tableView.isHidden = false
            })
            }
        
    }
    
    
}

extension ViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! Cell
        let row = results[indexPath.row]
        cell.nameLabel.text = row["name"] as? String
        cell.addressLabel.text = row["address"] as? String
        cell.addressLabel.lineBreakMode = .byWordWrapping
        cell.addressLabel.numberOfLines = 0
        let boolValue = row["available"] as? Bool
        if boolValue == false
        {
        cell.availableLabel.text = "CLOSE"
        }
        else
        {
            cell.availableLabel.text = "OPEN"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
   
}

