//
//  IngresseErrors.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 10/31/16.
//  Copyright © 2016 Ingresse. All rights reserved.
//

import UIKit

public class IngresseErrorsSwift: NSObject {
    static let shared = IngresseErrorsSwift()
    
    var errors: [String:String]!
    
    public override init() {
        let bundle = Bundle(identifier: "com.ingresse.sdk")
        guard let path = bundle?.path(forResource: "IngresseErrors", ofType: "plist") else {
            print("Path error")
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: path) else {
            print("Dict error")
            return
        }
        
        self.errors = dict as! [String:String]
    }
    
    public func getErrorMessage(code:Int) -> String {
        if code == 0 {
            return errors["default_no_code"]!
        }
        
        guard let error = errors["\(code)"] else {
            return String(format: errors["default"]!, arguments: [code])
        }
        
        return error
    }
}
