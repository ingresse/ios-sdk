//
//  Session.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Session: JSONConvertible {
    public var id: String = ""
    public var date: String = ""
    public var dateTime: Date?
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "id" {
                self.id = String(json[key] as! Int)
                continue
            }
            
            if key == "datetime" {
                guard let timestamp = json[key] as? String else { continue }
                
                self.date = timestamp.toDate().toString(format: .dateHourAt)
                self.dateTime = timestamp.toDate()
                
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
