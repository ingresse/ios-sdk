//
//  PaginationInfo.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaginationInfo: NSObject, Codable {
    public var currentPage: Int = 0
    public var lastPage: Int = 0
    public var totalResults: Int = 0
    public var pageSize: Int = 0
    
    public var isLastPage: Bool {
        get {
            return lastPage <= currentPage
        }
    }
    
    public var nextPage: Int {
        get {
            return currentPage + 1
        }
    }
}
