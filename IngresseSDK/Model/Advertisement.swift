//
//  Advertisement.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Advertisement: JSONConvertible {
    
    public var coverUrl: String = ""
    public var coverImage: String = ""
    public var backgroundImage: String = ""
    
    public override func applyJSON(_ json: [String : Any]) {
        if let cover = json["cover"] as? [String:Any] {
            self.coverUrl = cover["url"] as? String ?? ""
            self.coverImage = cover["image"] as? String ?? ""
        }
        
        if let background = json["background"] as? [String:Any] {
            self.backgroundImage = background["image"] as? String ?? ""
        }
    }
}
