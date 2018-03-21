//
//  JSONParser.swift
//  SwiftyJSONDemo
//
//  Created by Appinventiv on 21/03/18.
//  Copyright © 2018 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

class JSONParser
{
    var JSONArray = [[String:Any]]()
    func parser(searchText : String, success : @escaping ([[String:Any]])-> Void)
    {
        let requiredText : String = searchText.replacingOccurrences(of: " ", with: "+")
        
        let url = URL(string : "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(requiredText)&key=AIzaSyDI-aWqj-fJGhW0EaKtB_Csrt6VYEA3SMc")!
        
        if let data = try? String(contentsOf: url) {
            let json = JSON(parseJSON: data)
           JSONArray.removeAll()
            parse(json : json)
            success(JSONArray)
        }
    }
        
    func parse(json: JSON) {
        for result in json["results"].arrayValue {
            let name = result["name"].stringValue
            let address = result["formatted_address"].stringValue
            let available = result["opening_hours"]["open_now"].boolValue
            let obj = ["name" : name,"address" : address,"available" : available] as [String : Any]
            JSONArray.append(obj)
        }
        
        
    }
}
