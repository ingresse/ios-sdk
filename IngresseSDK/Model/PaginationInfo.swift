//
//  PaginationInfo.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PaginationInfo: NSObject, Codable {
    public var currentPage: Int
    public var lastPage: Int
    public var totalResults: Int
    public var pageSize: Int
    
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

    public override init() {
        currentPage = 0
        lastPage = 0
        totalResults = 0
        pageSize = 0
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        currentPage = try container.decodeIfPresent(Int.self, forKey: .currentPage) ?? 0
        lastPage = try container.decodeIfPresent(Int.self, forKey: .lastPage) ?? 0
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? 0
        pageSize = try container.decodeIfPresent(Int.self, forKey: .pageSize) ?? 0
    }
}
