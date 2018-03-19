//
//  NewEventSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/12/18.
//

public protocol NewEventSyncDelegate {
    func didSyncEvents(_ events: [NewEvent], page: ElasticPagination)
    func didFail(error: APIError)
}
