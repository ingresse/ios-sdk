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
    
    /**
     Get sessions user has tickets to
     
     - parameter type: Session type (.future, .past, .all)
     - parameter page: page of request
     
     - parameter delegate: Callback interface
     */
    public func getUserSessions(_ type: EventSessionType, page: Int, delegate: SessionSyncDelegate) {
        let user = IngresseUser.user!
        
        let path = "user/\(user.userId)/sessions"
        var parameters = ["page": "\(page)"]
        parameters["pageSize"] = "50"
        parameters["usertoken"] = user.userToken
        
        let day = 24*60*60
        let dayInterval = TimeInterval(-day)
        let date = Date(timeIntervalSinceNow: dayInterval)
        
        switch type {
        case .future: parameters["from"] = "\(date)"
        case .past  : parameters["to"] = "\(date)"
        case .all   : break
        }
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: parameters)
        
        client.restClient.GET(url: url) { (success: Bool, response: [String:Any]) in
            if !success {
                delegate.didFailSyncSessions(errorData: response)
                return
            }

            var eventDates = [Session]()
            var lastPage = 0
            var currentPage = 0

            guard let data = response["data"] as? [[String:AnyObject]] else {
                delegate.didFailSyncSessions(errorData: ["response": response])
                return
            }

            for obj in data {
                eventDates.append(Session(withJSON: obj))
            }

            guard let pagination = response["paginationInfo"] as? [String:AnyObject] else {
                delegate.didFailSyncSessions(errorData: ["response": response])
                return
            }
            
            lastPage = pagination["lastPage"] as? Int ?? 0
            currentPage = pagination["currentPage"] as? Int ?? 0

            let finished = lastPage <= currentPage

            delegate.didSyncSessionsPage(eventDates, finished: finished)

            if !finished {
                self.getUserSessions(type, page: currentPage+1, delegate: delegate)
            }
        }
    }

    /**
     Get tickets user has to specific session
     
     - parameter sessionId: Id of the session
     - parameter page: page of request
     
     - parameter delegate: Callback interface
     */
    public func getTicketsForSession(_ sessionID: String, page: Int, delegate: TicketSyncDelegate) {
        let user = IngresseUser.user!

        let path = "user/\(user.userId)/sessions/\(sessionID)/tickets"
        var parameters = ["page": "\(page)"]
        parameters["pageSize"] = "100"
        parameters["usertoken"] = user.userToken

        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: parameters)

        client.restClient.GET(url: url) { (success: Bool, response: [String: Any]) in
            if !success {
                delegate.didFailSyncTickets(errorData: response)
                return
            }

            var tickets = [UserTicket]()
            var lastPage = 0
            var currentPage = 0

            guard let data = response["data"] as? [[String:AnyObject]] else {
                delegate.didFailSyncTickets(errorData: ["response": response])
                return
            }

            for obj in data {
                tickets.append(UserTicket(withJSON: obj))
            }

            guard let pagination = response["paginationInfo"] as? [String:AnyObject] else {
                delegate.didFailSyncTickets(errorData: ["response": response])
                return
            }

            lastPage = pagination["lastPage"] as? Int ?? 0
            currentPage = pagination["currentPage"] as? Int ?? 0

            let finished = lastPage <= currentPage

            delegate.didSyncTicketsPage(tickets: tickets, finished: finished)

            if !finished {
                self.getTicketsForSession(sessionID, page: currentPage+1, delegate: delegate)
            }
        }
    }

    /**
     Get all tickets of user (sessionId = 0 *WildCard*)
     
     - parameter delegate: Callback interface
     */
    public func getAllUserTickets(delegate: TicketSyncDelegate) {
        self.getTicketsForSession("0", page: 1, delegate: delegate)
    }
}
