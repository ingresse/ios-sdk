//
//  MyTicketsService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public enum EventSessionType : Int {
    case future = 2
    case past = 1
    case all = 0
}

public class MyTicketsService: BaseService {
    
    /// Get sessions user has tickets to
    ///
    /// - Parameters:
    ///   - type: Session type (.future, .past, .all)
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserWallet(userId: String, userToken: String, page: Int, delegate: WalletSyncDelegate) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)/wallet")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncItems(errorData: APIError.getDefaultError())
                    return
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationObj)
            
            var items = [WalletItem]()
            for obj in data {
                let item = WalletItem()
                item.applyJSON(obj)
                items.append(item)
            }
            
            delegate.didSyncItemsPage(items, pagination: pagination)
        }) { (error) in
            delegate.didFailSyncItems(errorData: error)
        }
    }
    
    /// Get all tickets user has
    ///
    /// - Parameters:
    ///   - eventId: Id of the session
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserTickets(userId: String, userToken: String, page: Int, delegate: TicketSyncDelegate) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)/tickets")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .addParameter(key: "pageSize", value: "25")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncTickets(errorData: APIError.getDefaultError())
                    return
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationObj)
            
            var tickets = [UserTicket]()
            for obj in data {
                let ticket = UserTicket()
                ticket.applyJSON(obj)
                tickets.append(ticket)
            }
            
            delegate.didSyncTicketsPage(tickets: tickets, pagination: pagination)
        }) { (error) in
            delegate.didFailSyncTickets(errorData: error)
        }
    }
}
