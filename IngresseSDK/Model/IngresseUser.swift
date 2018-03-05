//
//  IngresseUser.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/16/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseUser: NSObject, Codable {
    public var userId: Int = 0
    public var token: String = ""
    public var data: UserData!
    
    public static var user : IngresseUser?
    
    static func login(loginData: [String:Any]) -> IngresseUser {
        let user = JSONDecoder().decodeDict(of: IngresseUser.self, from: loginData) ?? IngresseUser()

        IngresseUser.user = user
        return user
    }
    
    static func fillData(userData: [String:Any]) {
        guard user != nil else {
            return
        }
        
        user!.data = JSONDecoder().decodeDict(of: UserData.self, from: userData)
    }
    
    public static func logout() {
        user = nil
    }
}
