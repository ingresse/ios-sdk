//
//  TicketSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol TicketSyncDelegate {
    func didSyncTicketsPage(tickets: [UserTicket], finished: Bool)
    func didFailSyncTickets(errorData: [String:Any])
}
