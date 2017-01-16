//
//  IngresseUser.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class IngresseUser: NSObject {
    var name      : String?
    var email     : String?
    var userId    : String?
    var userToken : String?
    var userType  : String?
    var fbToken   : String?
    var facebook  : Bool?
    
    static var user : IngresseUser?
    
    static func login(userData: [String:Any]) -> IngresseUser {
        user = IngresseUser()
        
        user!.userId = userData["userId"] as? String
        user!.userToken = userData["token"] as? String
        
        return user!
    }
    
    static func logout() {
        user = nil
    }
}
