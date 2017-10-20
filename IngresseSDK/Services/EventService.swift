//
//  EventService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventService: BaseService {
    
    /// Get attributes of event
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getEventAttributes(eventId: String, onSuccess: @escaping (_ attributes: EventAttributes)->(), onError: @escaping (_ errorData: APIError)->()) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            let attributes = EventAttributes()
            attributes.applyJSON(response)
            
            onSuccess(attributes)
        }) { (error) in
            onError(error)
        }
    }
    
    /// Get advertisement info for event
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getAdvertisement(ofEvent eventId: String, onSuccess: @escaping (_ ads: Advertisement)->(), onError: @escaping (_ errorData: APIError)->()) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .addParameter(key: "filter", value: "advertisement")
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let obj = response["advertisement"] as? [String:Any],
                let mobile = obj["mobile"] as? [String:Any]
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            let ads = Advertisement()
            ads.applyJSON(mobile)
            onSuccess(ads)
        }) { (error) in
            onError(error)
        }
    }
    
    
    public func getTickets(ofEvent eventId: String, pos: Bool = false, asUsertoken: String = "", onSuccess: @escaping (_ tickets: [EventTicket])->(), onError: @escaping (_ errorData: APIError)->()) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/0/tickets")
            .addParameter(key: "pos", value: "\(pos)")
            .addParameter(key: "usertoken", value: asUsertoken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            
            var tickets = [EventTicket]()
            guard
                let data = response["data"] as? [[String:Any]]
            else {
                return
            }
            
            for obj in data {
                print(obj)
                let ticket = EventTicket()
                ticket.applyJSON(obj)
                tickets.append(ticket)
            }
            
            onSuccess(tickets)
            
        }) { (error) in
            onError(error)
        }
        
        
    }
}
