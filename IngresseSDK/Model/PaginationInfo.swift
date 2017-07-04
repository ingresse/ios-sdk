//
//  PaginationInfo.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class PaginationInfo: JSONConvertible {
    
    public var currentPage: Int = 0
    public var lastPage: Int = 0
    public var totalResults: Int = 0
    public var pageSize: String = ""

    public var isLastPage: Bool {
        get {
            return lastPage <= currentPage
        }
    }
}
