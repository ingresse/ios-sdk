//
//  Event.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class Event: JSONConvertible {
    public var id: Int = 0
    public var title: String = ""
    public var link: String = ""
    public var type: String = ""
    public var poster: String = ""
    public var status: String = ""
    public var saleEnabled: Bool = false
    public var eventDescription: String = ""
    
    public override func applyJSON(_ json: [String : Any]) {
        for (key,value) in json {
            if key == "description" {
                guard let desc = value as? String else { continue }
                
                self.eventDescription = desc
                continue
            }
            
            applyKey(key, value: value)
        }
    }
}
