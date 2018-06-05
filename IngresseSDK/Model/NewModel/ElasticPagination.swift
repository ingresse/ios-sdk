//
//  ElasticPagination.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/16/18.
//

public struct ElasticPagination {
    public var size: Int = 100
    public var total: Int = 0
    public var currentOffset: Int = 0

    public init () {}

    public var nextOffset: Int {
        return currentOffset + size
    }

    public var isLastPage: Bool {
        return currentOffset + size >= total
    }
}
