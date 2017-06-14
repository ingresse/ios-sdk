//
//  CheckinSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/25/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import Foundation

@objc public protocol CheckinSyncDelegate {
    
    func didCheckinTickets(_ tickets: [CheckinTicket])
    func didFailCheckin(errorData: APIError)
}
