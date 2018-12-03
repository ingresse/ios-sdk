//
//  TicketSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol TicketSyncDelegate {
    func didSyncTicketsPage(eventId: String, tickets: [UserTicket], pagination: PaginationInfo)
    func didFailSyncTickets(errorData: APIError)
}
