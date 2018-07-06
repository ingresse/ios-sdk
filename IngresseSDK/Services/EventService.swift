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
    
    /// Get event details
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getEventDetails(eventId: String, onSuccess: @escaping (_ attributes: Event)->(), onError: @escaping (_ errorData: APIError)->()) {

        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let event = JSONDecoder().decodeDict(of: Event.self, from: response) else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(event)
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
                let mobile = obj["mobile"] as? [String:Any],
                let ads = JSONDecoder().decodeDict(of: Advertisement.self, from: mobile)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

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
    public func getEvents(from place: String,
        ofCategories categories: [Int],
        andSearchTerm searchTerm: String,
        page: ElasticPagination,
        delegate: NewEventSyncDelegate) {

        let url = URLBuilder(client: client)
            .setHost("https://hml-event.ingresse.com/")
            .setPath("search/company/1")
            .addParameter(key: "state", value: place)
//            .addParameter(key: "from", value: "now-6h")
            .addParameter(key: "size", value: page.size)
            .addParameter(key: "offset", value: page.currentOffset)
            .buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String:Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    delegate.didFail(error: APIError.getDefaultError())
                    return
            }

            var pagination = page
            pagination.total = total

            delegate.didSyncEvents(events, page: pagination)
        }) { (error) in
            delegate.didFail(error: error)
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
    public func getCategories(onSuccess: @escaping (_ categories: [Category])->(), onError: @escaping (_ errorData: APIError)->()) {

        let url = URLBuilder(client: client)
            .setHost("https://hml-event.ingresse.com/")
            .setPath("categories")
            //            .addParameter(key: "category", value: categories.map{ String($0) }.joined(separator: ","))
            .buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let categories = JSONDecoder().decodeArray(of: [Category].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(categories)
        }) { (error) in
            onError(error)
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
            guard
                let data = response["data"] as? [[String:Any]],
                let events = JSONDecoder().decodeArray(of: [Highlight].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(events)
        }) { (error) in
            onError(error)
        }
    }
}
