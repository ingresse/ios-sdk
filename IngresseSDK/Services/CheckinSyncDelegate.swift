//
//  CheckinSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/25/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

@objc public protocol CheckinSyncDelegate {
    
    func didCheckinTickets(_ tickets: [CheckinTicketData])
    func didFailCheckin(errorData: APIError)
}
