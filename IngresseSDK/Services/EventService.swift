//
//  EventService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public protocol EventSyncDelegate {
    func didSyncEvents(_ events: [IngresseSDK.Event], of category: Int, page: PaginationInfo)
    func didFailSyncEvents(errorData: APIError)
}

public class EventService: BaseService {

    let categories = ["event", "featured", "festas_e_baladas", "universitario", "shows_e_festivais", "teatro"]

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

    /// Get event list from state and category with search term
    ///
    /// - Parameters:
    ///   - page: Index of page to get
    ///   - place: Abbreviation of the state
    ///   - category: ID of the category
    ///   - searchTerm: Term to filter event list
    ///   - delegate: Callback listener
    public func getEvents(page: Int,
        from place: String,
        ofCategory category: Int,
        andSearchTerm searchTerm: String,
        delegate: EventSyncDelegate) {
        let path = categories[category]

        let fields = "id,title,planner,date,venue,rsvp,saleEnabled,type,link,poster,description"
        let url = URLBuilder(client: client)
            .setPath(path)
            .addParameter(key: "term", value: searchTerm)
            .addParameter(key: "state", value: place)
            .addParameter(key: "fields", value: fields)
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "200")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailSyncEvents(errorData: APIError.getDefaultError())
                    return
            }

            let pagination = PaginationInfo()
            pagination.applyJSON(paginationObj)

            var events = [Event]()
            for obj in data {
                let event = Event()
                event.applyJSON(obj)
                events.append(event)
            }

            delegate.didSyncEvents(events, of: category, page: pagination)
        }) { (error) in
            delegate.didFailSyncEvents(errorData: error)
        }
    }


    /// Get banners of featured events
    ///
    /// - Parameters:
    ///   - place: Abbreviation of the state
    public func getFeaturedEvents(
        from place: String,
        onSuccess: @escaping (_ highlights: [Highlight])->(),
        onError: @escaping (_ errorData: APIError)->()) {

        let url = URLBuilder(client: client)
            .setPath("featured")
            .addParameter(key: "page", value: "1")
            .addParameter(key: "pageSize", value: "25")
            .addParameter(key: "method", value: "banner")
            .addParameter(key: "state", value: place)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String:Any]] else {
                onError(APIError.getDefaultError())
                return
            }

            var events = [Highlight]()
            for obj in data {
                let event = Highlight()
                event.applyJSON(obj)
                events.append(event)
            }

            onSuccess(events)
        }) { (error) in
            onError(error)
        }
    }
}
