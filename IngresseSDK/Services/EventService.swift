//
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
    public func getEventAttributes(eventId: String, onSuccess: @escaping (_ attributes: EventAttributes) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            let attributes = JSONDecoder().decodeDict(of: EventAttributes.self, from: response)!
            onSuccess(attributes)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    public func getSpecialEvents(onSuccess: @escaping (_ specialEvents: [String: Response.Events.SpecialEvent]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        
        let url = "https://35fd0qp7if.execute-api.us-east-1.amazonaws.com/beta"
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            let specialEvents = JSONDecoder().decodeDict(of: [String: Response.Events.SpecialEvent].self, from: response)!
            onSuccess(specialEvents)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    /// Get event details
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getEventDetails(eventId: String, slug: String = "", onSuccess: @escaping (_ details: Event) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {

        var builder = URLBuilder(client: client)
            .setPath("event/\(eventId)")
            .addParameter(key: "fields",
                          value: "title,planner,link,description,date,ticket,venue, saleEnabled,id,status,customTickets,rsvp,rsvpTotal,type,poster")

        if slug != "" {
            builder = builder.setPath("event")
            builder = builder.addParameter(key: "method", value: "identify")
            builder = builder.addParameter(key: "link", value: slug)
        }

        let url = builder.build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let event = JSONDecoder().decodeDict(of: Event.self, from: response) else { return }
            onSuccess(event)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get advertisement info for event
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getAdvertisement(ofEvent eventId: Int, onSuccess: @escaping (_ ads: Advertisement) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .addParameter(key: "filter", value: "advertisement")
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let obj = response["advertisement"] as? [String: Any],
                let mobile = obj["mobile"] as? [String: Any],
                let ads = JSONDecoder().decodeDict(of: Advertisement.self, from: mobile)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            ads.eventId = eventId
            onSuccess(ads)
        }, onError: { (error) in
            onError(error)
        })
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
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "state", value: place)
            .addParameter(key: "size", value: page.size)
            .addParameter(key: "from", value: "now-6h")
            .addParameter(key: "offset", value: page.currentOffset)
            .buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    delegate.didFail(error: APIError.getDefaultError())
                    return
            }

            var pagination = page
            pagination.total = total

            delegate.didSyncEvents(events, page: pagination)
        }, onError: { (error) in
            delegate.didFail(error: error)
        })
    }

    /// Get event list from state and category with search term
    ///
    /// - Parameters:
    ///   - page: Index of page to get
    ///   - place: Abbreviation of the state
    ///   - category: ID of the category
    ///   - searchTerm: Term to filter event list
    ///   - delegate: Callback listener
    public func getCategories(onSuccess: @escaping (_ categories: [Category]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setHost(.events)
            .setPath("categories")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let categories = JSONDecoder().decodeArray(of: [Category].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(categories)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get banners of featured events
    ///
    /// - Parameters:
    ///   - place: Abbreviation of the state
    public func getFeaturedEvents(
        from place: String,
        onSuccess: @escaping (_ highlights: [Highlight]) -> Void,
        onError: @escaping (_ errorData: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("featured")
            .addParameter(key: "page", value: "1")
            .addParameter(key: "pageSize", value: "25")
            .addParameter(key: "method", value: "banner")
            .addParameter(key: "state", value: place)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [Highlight].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(events)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get event details
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func rsvpResponse(eventId: String, userToken: String, willGo: Bool, onSuccess: @escaping () -> Void, onError: @escaping (_ errorData: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/rsvp")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "method", value: willGo ? "add" : "remove")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let status = response["status"] as? Int,
                status == 1 else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }
    
    /// Get session details
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - sessionId: id from current session
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getSessionDetails(eventId: String, sessionId: String, onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/\(sessionId)/tickets")
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String: Any]],
                let types = JSONDecoder().decodeArray(of: [TicketGroup].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(types)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get Event PassKey
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - passkeyCode: passkey code to show tickets
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getEventPassKey(eventId: String, passkeyCode: String, onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/0/tickets")
            .addParameter(key: "passkey", value: passkeyCode)
            .build()

        var newTickets = [TicketGroup]()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String: Any]],
                let types = JSONDecoder().decodeArray(of: [TicketGroup].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            newTickets.append(contentsOf: types)

            self.getEventPassportsPassKey(eventId: eventId,
                                          passkeyCode: passkeyCode,
                                          onSuccess: { (groups) in
                                            newTickets.append(contentsOf: groups)
                                            onSuccess(newTickets) },
                                          onError: { (error) in onError(error) })
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get Event Passports PassKey
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - passkeyCode: passkey code to show passports
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getEventPassportsPassKey(eventId: String, passkeyCode: String, onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/passports/tickets")
            .addParameter(key: "passkey", value: passkeyCode)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String: Any]],
                let types = JSONDecoder().decodeArray(of: [TicketGroup].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(types)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    public func getEventsByProducer(request: Request.Event.Producer,
                                    delegate: ProducerEventSyncDelegate) {
        
        let url = URLBuilder(client: client)
            .setHost(.events)
            .setPath("search/producer")
            .addParameter(key: "orderBy", value: request.orderBy)
            .addParameter(key: "size", value: request.size)
            .addParameter(key: "to", value: request.to)
            .addParameter(key: "from", value: request.from)
            .addParameter(key: "offset", value: request.offset)
            .buildWithoutKeys()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    delegate.didFail(error: APIError.getDefaultError())
                    return
            }
            
            let newOffset = request.offset+request.size
            delegate.didSyncEvents(events, offset: newOffset, total: total)
        }, onError: { (error) in
            delegate.didFail(error: error)
        })
    }
}
