//
//  MyTicketsService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

public enum EventSessionType {
    case future
    case past
    case all
}

public class MyTicketsService {
    
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
        var parameters = ["page":"\(page)"]
        parameters["pageSize"] = "50"
        parameters["usertoken"] = user.userToken
        
        let date = Date(timeIntervalSinceNow:-(2*24*60*60))
        
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
            
            let data = response["data"] as! [[String:AnyObject]]
            
            for obj in data {
                eventDates.append(Session(withJSON: obj))
            }
            
            let pagination = response["paginationInfo"] as! [String:AnyObject]
            lastPage = pagination["lastPage"] as! Int
            currentPage = pagination["currentPage"] as! Int
            
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
        var parameters = ["page":"\(page)"]
        parameters["pageSize"] = "100"
        parameters["usertoken"] = user.userToken
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: parameters)
        
        client.restClient.GET(url: url) { (success:Bool, response:[String : Any]) in
            if !success {
                delegate.didFailSyncTickets(errorData: response)
                return
            }
            
            var tickets = [UserTicket]()
            var lastPage = 0
            var currentPage = 0
            
            let data = response["data"] as! [[String:AnyObject]]
            
            for obj in data {
                tickets.append(UserTicket(withJSON: obj))
            }
            
            let pagination = response["paginationInfo"] as! [String:AnyObject]
            lastPage = pagination["lastPage"] as! Int
            currentPage = pagination["currentPage"] as! Int
            
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
