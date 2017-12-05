//
//  BaseService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class BaseService: NSObject {
    var client: IngresseClient
        
    init(_ client:IngresseClient) {
        self.client = client
    }
}
