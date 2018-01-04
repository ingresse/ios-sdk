//
//  IngresseUser.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objcMembers public class IngresseUser: JSONConvertible {
    public var userId: Int = 0
    public var token: String = ""
    public var data: UserData?
    
    public static var user : IngresseUser?
    
    static func login(loginData: [String:Any]) -> IngresseUser {
        user = IngresseUser()
        
        user!.applyJSON(loginData)
        
        return user!
    }
    
    static func fillData(userData: [String:Any]) {
        guard user != nil else {
            return
        }
        
        user!.data = UserData()
        user!.data!.applyJSON(userData)
    }
    
    public static func logout() {
        user = nil
    }
}
