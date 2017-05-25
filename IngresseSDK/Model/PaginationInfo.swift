//
//  PaginationInfo.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class PaginationInfo: JSONConvertible {
    
    public var currentPage: Int
    public var lastPage: Int
    public var totalResults: Int
    public var pageSize: String

    public var isLastPage: Bool {
        get {
            return lastPage <= currentPage
        }
    }
    
    // Empty init
    override init() {
        self.currentPage = 0
        self.lastPage = 0
        self.totalResults = 0
        self.pageSize = ""
    }
}
