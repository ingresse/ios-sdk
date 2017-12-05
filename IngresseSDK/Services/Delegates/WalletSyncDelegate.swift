//
//  SessionSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/19/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol WalletSyncDelegate {
    func didSyncItemsPage(_ items: [WalletItem], pagination: PaginationInfo)
    func didFailSyncItems(errorData: APIError)
}
