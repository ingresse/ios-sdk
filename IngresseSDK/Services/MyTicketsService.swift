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

public class MyTicketsService: NSObject {
    
    var client: IngresseClient
    
    init(_ client: IngresseClient) {
        self.client = client
    }

    /// Get sessions user has tickets to
    ///
    /// - Parameters:
    ///   - type: Session type (.future, .past, .all)
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserSessions(_ type: EventSessionType, page: Int, delegate: SessionSyncDelegate) {
        let user = IngresseUser.user!
        
        var builder = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("user/\(user.userId)/sessions")
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "50")
            .addParameter(key: "usertoken", value: user.token)
        
        let day = 24*60*60
        let dayInterval = TimeInterval(-day)
        let date = Date(timeIntervalSinceNow: dayInterval)
        
        switch type {
        case .future: builder = builder.addParameter(key: "from", value: "\(date)")
        case .past  : builder = builder.addParameter(key: "to", value: "\(date)")
        case .all   : break
        }
        
        let url = builder.build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            var eventDates = [Session]()
            
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncSessions(errorData: APIError.getDefaultError())
                    return
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationObj)
            
            for obj in data {
                let session = Session()
                session.applyJSON(obj)
                eventDates.append(session)
            }
            
            delegate.didSyncSessionsPage(eventDates, pagination: pagination)
        }) { (error) in
            delegate.didFailSyncSessions(errorData: error)
        }
    }
    
    /// Get tickets user has to specific session
    ///
    /// - Parameters:
    ///   - sessionID: Id of the session
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getTicketsForSession(_ sessionID: String, page: Int, delegate: TicketSyncDelegate) {
        let user = IngresseUser.user!
        
        let url = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("user/\(user.userId)/sessions/\(sessionID)/tickets")
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "100")
            .addParameter(key: "usertoken", value: user.token)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            var tickets = [UserTicket]()
            
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncTickets(errorData: APIError.getDefaultError())
                    return
            }
            
            let pagination = PaginationInfo()
            pagination.applyJSON(paginationObj)
            
            
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
    
    /// Get all tickets of user (sessionId = 0 *WildCard*)
    ///
    /// - Parameter delegate: Callback interface
    public func getAllUserTickets(delegate: TicketSyncDelegate) {
        self.getTicketsForSession("0", page: 1, delegate: delegate)
    }
}
