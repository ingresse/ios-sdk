//
//  EntranceService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

public class EntranceService: NSObject {
    
    var client: IngresseClient
    var delegate: GuestListSyncDelegate!
    
    init(_ client: IngresseClient) {
        self.client = client
    }
    
    /// Get list of tickets for entrance (Guest List)
    ///
    /// - Requires: User token (logged user)
    ///
    /// - Parameters:
    ///   - eventId:    id of the event
    ///   - sessionId:  id of the event's session
    ///   - userToken:  user token required to make request
    ///   - page:       result page
    ///
    ///   - delegate:   callback listener
    public func getGuestListOfEvent(_ eventId: String, sessionId: String, userToken: String, page: Int, delegate: GuestListSyncDelegate) {
        
        let path = "event/\(eventId)/guestlist"
        
        var params = ["sessionid": sessionId]
        params["usertoken"] = userToken
        params["pageSize"] = "3000"
        params["page"] = "\(page)"
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: params)
        
        client.restClient.GET(url: url) { (success: Bool, response: [String:Any]) in
            // Request status
            if !success {
                guard let error = response["error"] as? APIError else {
                    delegate.didFailSyncGuestList(errorData: APIError.getDefaultError())
                    return
                }
                
                delegate.didFailSyncGuestList(errorData: error)
                return
            }
            
            var guests = [Guest]()
            
            // Get array
            guard let data = response["data"] as? [[String:Any]] else {
                delegate.didFailSyncGuestList(errorData: APIError.getDefaultError())
                return
            }
            
            for obj in data {
                let guest = Guest()
                guest.applyJSON(obj)
                
                guests.append(guest)
            }
            
            guard let paginationData = response["paginationInfo"] as? [String:AnyObject] else {
                delegate.didFailSyncGuestList(errorData: APIError.getDefaultError())
                return
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationData)
            
            let finished = pagination.isLastPage
            
            delegate.didSyncGuestsPage(pagination, guests, finished: finished)
            
            if !finished {
                self.getGuestListOfEvent(eventId, sessionId: sessionId, userToken: userToken, page: pagination.currentPage + 1, delegate: delegate)
            }

        }
    }
    
    public func checkinTickets(_ ticketCodes: [String], ticketStatus: [String], ticketTimestamps: [String], eventId: String, userToken: String, delegate: CheckinSyncDelegate) {
        let path = "event/\(eventId)/guestlist"
        
        var urlParams = ["method": "updatestatus"]
        urlParams["usertoken"] = userToken
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: urlParams)
        
        var postParams = [String:String]()
        for i in 0..<ticketCodes.count {
            postParams["tickets[\(i)][ticketCode]"] = ticketCodes[i]
            postParams["tickets[\(i)][ticketStatus]"] = ticketStatus[i]
            postParams["tickets[\(i)][ticketTimestamp]"] = ticketTimestamps[i]
        }
        
        client.restClient.POST(url: url, parameters: postParams) { (success: Bool, response: [String:Any]) in
            if !success {
                guard let error = response["error"] as? APIError else {
                    delegate.didFailCheckin(errorData: APIError.getDefaultError())
                    return
                }
                
                delegate.didFailCheckin(errorData: error)
                return
            }
            
            guard let data = response["data"] as? [[String:Any]] else {
                delegate.didFailCheckin(errorData: APIError.getDefaultError())
                return
            }
            
            var tickets = [CheckinTicketData]()
            for obj in data {
                let ticket = CheckinTicketData()
                ticket.applyJSON(obj)
                
                tickets.append(ticket)
            }
            
            delegate.didCheckinTickets(tickets)
        }
    }

}
