//
//  IngresseUser.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class IngresseUser: NSObject {
    public var userId    : Int?
    public var name      : String?
    public var lastname  : String?
    public var email     : String?
    public var userToken : String?
    public var state     : String?
    public var city      : String?
    public var district  : String?
    public var street    : String?
    public var zip       : String?
    public var complement: String?
    public var phone     : String?
    public var number    : String?
    public var fbUserId  : String?
    public var verified  : Bool?
    
    public static var user : IngresseUser?
    
    static func login(userData: [String:Any]) -> IngresseUser {
        user = IngresseUser()
        
        user!.userId = userData["userId"] as? Int
        user!.userToken = userData["token"] as? String
        
        return user!
    }
    
    static func fillData(userData: [String:Any]) -> IngresseUser? {
        guard user != nil else {
            return nil
        }
        
        user!.userId     = userData["id"] as? Int
        user!.name       = userData["name"] as? String
        user!.lastname   = userData["lastname"] as? String
        user!.email      = userData["email"] as? String
        user!.state      = userData["state"] as? String
        user!.city       = userData["city"] as? String
        user!.district   = userData["district"] as? String
        user!.street     = userData["street"] as? String
        user!.number     = userData["number"] as? String
        user!.zip        = userData["zip"] as? String
        user!.complement = userData["complement"] as? String
        user!.phone      = userData["phone"] as? String
        user!.fbUserId   = userData["fbUserId"] as? String
        user!.verified   = userData["verified"] as? Bool
        
        return user!
    }
    
    public static func logout() {
        user = nil
    }
}
