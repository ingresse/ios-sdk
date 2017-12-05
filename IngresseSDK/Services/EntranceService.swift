//
//  EntranceService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EntranceService: BaseService {
    
    var shouldStop = false
    
    public func stopDownload() {
        shouldStop = true
    }

    public func allowDownload() {
        shouldStop = false
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
    public func getGuestListOfEvent(_ eventId: String, sessionId: String, from: Int = 0, userToken: String, page: Int, delegate: GuestListSyncDelegate) {
        
        if shouldStop {
            return
        }

        var builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "3000")
            .addParameter(key: "sessionid", value: sessionId)
            .addParameter(key: "usertoken", value: userToken)
        
        if from != 0 {
            builder = builder.addParameter(key: "from", value: "\(from)")
        }
        
        let url = builder.build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            var guests = [GuestTicket]()
            
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationData = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncGuestList(errorData: APIError.getDefaultError())
                    return
            }
            
            for obj in data {
                let guest = GuestTicket()
                guest.applyJSON(obj)
                
                guests.append(guest)
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationData)
            
            delegate.didSyncGuestsPage(pagination, guests)

            if pagination.isLastPage {
                return
            }

            self.getGuestListOfEvent(eventId, sessionId: sessionId, from: from, userToken: userToken, page: pagination.currentPage+1, delegate: delegate)

        }) { (error) in
            delegate.didFailSyncGuestList(errorData: error)
        }
    }
    
    /// Make checkin of tickets
    ///
    /// - Parameters:
    ///   - ticketCodes: array with ticketCodes
    ///   - ticketStatus: array with ticketStatus
    ///   - ticketTimestamps: array with timestamps of last update
    ///   - eventId: id of the event
    ///   - userToken: token of logged user
    ///   - delegate: delegate to receive callbacks
    public func checkinTickets(_ ticketCodes: [String], ticketStatus: [String], ticketTimestamps: [String], eventId: String, sessionId: String, userToken: String, delegate: CheckinSyncDelegate) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "method", value: "updatestatus")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "sessionId", value: sessionId)
            .build()
        
        var postParams = [String:String]()
        for i in 0..<ticketCodes.count {
            postParams["tickets[\(i)][ticketCode]"] = ticketCodes[i]
            postParams["tickets[\(i)][ticketStatus]"] = ticketStatus[i]
            postParams["tickets[\(i)][ticketTimestamp]"] = ticketTimestamps[i]
        }
        
        client.restClient.POST(url: url, parameters: postParams, onSuccess: { (response) in
            guard let data = response["data"] as? [[String:Any]] else {
                delegate.didFailCheckin(errorData: APIError.getDefaultError())
                return
            }
            
            var tickets = [CheckinTicket]()
            for obj in data {
                let ticket = CheckinTicket()
                ticket.applyJSON(obj)
                
                tickets.append(ticket)
            }
            
            delegate.didCheckinTickets(tickets)
        }) { (error) in
            delegate.didFailCheckin(errorData: error)
        }
    }
    
    /// Get validation info of ticket
    ///
    /// - Parameters:
    ///   - code: ticket code
    ///   - eventId: event id
    ///   - userToken: token required
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getValidationInfoOfTicket(code: String, eventId: String, sessionId: String, userToken: String, onSuccess: @escaping (_ ticket: CheckinTicket)->(), onError: @escaping (_ error: APIError)->()) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "method", value: "updatestatus")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "sessionId", value: sessionId)
            .build()
        
        var postParams = [String:String]()
        postParams["tickets[0][ticketCode]"] = code
        postParams["tickets[0][ticketStatus]"] = "1"
        postParams["tickets[0][ticketTimestamp]"] = "\(Int(Date().timeIntervalSince1970)*1000)"
        
        client.restClient.POST(url: url, parameters: postParams, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let ticketData = data.first
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            let ticket = CheckinTicket()
            ticket.applyJSON(ticketData)
            
            onSuccess(ticket)
        }) { (error) in
            onError(error)
        }
    }
    
    /// Get transfer history of ticket
    ///
    /// - Parameters:
    ///   - ticketId: id of ticket
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getTransferHistory(ticketId: String, userToken: String, onSuccess: @escaping (_ history: [TransferHistoryItem])->(), onError: @escaping (_ error: APIError)->()) {
        
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticketId)/transfer")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String:Any]] else {
                onError(APIError.getDefaultError())
                return
            }
            
            var history = [TransferHistoryItem]()
            for obj in data {
                let item = TransferHistoryItem()
                item.applyJSON(obj)
                
                history.append(item)
            }
            
            onSuccess(history)
        }) { (error) in
            onError(error)
        }
    }
}
