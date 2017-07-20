//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: JSONConvertible {
    public var id: String = ""
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var eventDescription: String = ""
    
    public override func applyJSON(_ json: [String : Any]) {
        for key:String in json.keys {
            
            if key == "id" {
                self.id = String(json[key] as! Int)
                continue
            }
            
            if key == "description" {
                guard let desc = json[key] as? String else { continue }
                
                self.eventDescription = desc
                continue
            }
            
            applyKey(key, json: json)
        }
    }
}
