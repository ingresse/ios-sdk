//
//  RestClientInterface.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/17/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public protocol RestClientInterface {
    
    func POST(url: String, parameters: [String:String], completion:@escaping (_ success:Bool, _ responseData:[String:Any]) -> ())
    func GET(url: String, completion:@escaping (_ success:Bool, _ responseData:[String:Any]) -> ())
}
