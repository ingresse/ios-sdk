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
    public func getEventAttributes(eventId: String,
                                   onSuccess: @escaping (_ attributes: EventAttributes) -> Void,
                                   onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            let attributes = JSONDecoder().decodeDict(of: EventAttributes.self, from: response)!
            onSuccess(attributes)
        }, onError: onError)
    }
    
    public func getSpecialEvents(onSuccess: @escaping (_ specialEvents: [String: Response.Events.SpecialEvent]) -> Void,
                                 onError: @escaping (_ errorData: APIError) -> Void) {
        
        let url = URL(string: "https://35fd0qp7if.execute-api.us-east-1.amazonaws.com/beta")!
        let request = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        client.restClient.GET(request: request,
                              onSuccess: { (response) in

            let specialEvents = JSONDecoder().decodeDict(of: [String: Response.Events.SpecialEvent].self, from: response)!
            onSuccess(specialEvents)
        }, onError: onError)
    }
    
    /// Get event details
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    @objc public func getEventDetails(eventId: String,
                                      slug: String = "",
                                      onSuccess: @escaping (_ details: Event) -> Void,
                                      onError: @escaping (_ errorData: APIError) -> Void) {

        var builder = URLBuilder(client: client)
            .setPath("event/\(eventId)")
            .addParameter(key: "fields",
                          value: "title,planner,link,description,date,ticket,venue, saleEnabled,id,status,customTickets,rsvp,rsvpTotal,type,poster")

        if slug != "" {
            builder = builder.setPath("event")
            builder = builder.addParameter(key: "method", value: "identify")
            builder = builder.addParameter(key: "link", value: slug)
        }

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in

            guard let event = JSONDecoder().decodeDict(of: Event.self, from: response) else { return }
            onSuccess(event)
        }, onError: onError)
    }

    /// Get event image detail
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getEventImageDetails(ofEvent eventId: Int, onSuccess: @escaping (_ details: EventImageDetails) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .addParameter(key: "filters", value: "start_image,start_image_description")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let details = JSONDecoder().decodeDict(of: EventImageDetails.self, from: response) else { return }
            onSuccess(details)
        }, onError: onError)
    }

    /// Get advertisement info for event
    ///
    /// - Parameters:
    ///   - eventId: id of the event
    public func getAdvertisement(ofEvent eventId: Int,
                                 onSuccess: @escaping (_ ads: Advertisement) -> Void,
                                 onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/attributes")
            .addParameter(key: "filters", value: "advertisement")
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
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "state", value: place)
            .addParameter(key: "size", value: page.size)
            .addParameter(key: "from", value: "now-6h")
            .addParameter(key: "offset", value: page.currentOffset)
        guard let request = try? builder.build() else {

            return delegate.didFail(error: APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
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
        }, onError: delegate.didFail)
    }

    /// Get event list from state and category with search term
    ///
    /// - Parameters:
    ///   - page: Index of page to get
    ///   - place: Abbreviation of the state
    ///   - category: ID of the category
    ///   - searchTerm: Term to filter event list
    ///   - delegate: Callback listener
    public func getCategories(onSuccess: @escaping (_ categories: [Category]) -> Void,
                              onError: @escaping (_ errorData: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setHost(.events)
            .setPath("categories")

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let categories = JSONDecoder().decodeArray(of: [Category].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(categories)
        }, onError: onError)
    }

    /// Get banners of featured events
    ///
    /// - Parameters:
    ///   - place: Abbreviation of the state
    public func getFeaturedEvents(
        from place: String,
        onSuccess: @escaping (_ highlights: [Highlight]) -> Void,
        onError: @escaping (_ errorData: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setPath("featured")
            .addParameter(key: "page", value: "1")
            .addParameter(key: "pageSize", value: "25")
            .addParameter(key: "method", value: "banner")
            .addParameter(key: "state", value: place)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [Highlight].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(events)
        }, onError: onError)
    }

    /// Get session details
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - sessionId: id from current session
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    @objc  public func getSessionDetails(eventId: String,
                                         sessionId: String,
                                         onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void,
                                         onError: @escaping (_ errorData: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/\(sessionId)/tickets")

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let data = response["data"] as? [[String: Any]],
                let types = JSONDecoder().decodeArray(of: [TicketGroup].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(types)
        }, onError: onError)
    }

    /// Get Event PassKey
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - passkeyCode: passkey code to show tickets
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getEventPassKey(eventId: String,
                                passkeyCode: String,
                                onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void,
                                onError: @escaping (_ errorData: APIError) -> Void) {
        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/0/tickets")
            .addParameter(key: "passkey", value: passkeyCode)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        var newTickets = [TicketGroup]()

        client.restClient.GET(request: request,
                              onSuccess: { response in
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
                                          onError: onError)
        }, onError: onError)
    }

    /// Get Event Passports PassKey
    ///
    /// - Parameters:
    ///   - eventId: id from current event
    ///   - passkeyCode: passkey code to show passports
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getEventPassportsPassKey(eventId: String,
                                         passkeyCode: String,
                                         onSuccess: @escaping (_ ticketGroups: [TicketGroup]) -> Void,
                                         onError: @escaping (_ errorData: APIError) -> Void) {
        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/session/passports/tickets")
            .addParameter(key: "passkey", value: passkeyCode)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let data = response["data"] as? [[String: Any]],
                let types = JSONDecoder().decodeArray(of: [TicketGroup].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(types)
        }, onError: onError)
    }
    
    public func getEventsByProducer(request: Request.Event.Producer,
                                    delegate: ProducerEventSyncDelegate) {
        
        let builder = URLBuilder(client: client)
            .setHost(.events)
            .setPath("search/producer")
            .addParameter(key: "orderBy", value: request.orderBy)
            .addParameter(key: "size", value: request.size)
            .addParameter(key: "to", value: request.to)
            .addParameter(key: "from", value: request.from)
            .addParameter(key: "offset", value: request.offset)

        guard let requestURL = try? builder.build() else {

            return delegate.didFail(error: APIError.getDefaultError())
        }
        client.restClient.GET(request: requestURL,
                              onSuccess: { response in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    delegate.didFail(error: APIError.getDefaultError())
                    return
            }
            
            let newOffset = request.offset + request.size
            delegate.didSyncEvents(events, offset: newOffset, total: total)
        }, onError: { error in
            delegate.didFail(error: error)
        })
    }

    /// Get RSVP list from event
    ///
    /// - Parameters:
    ///   - eventId: id of event to get rsvp list
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func getRSVPList(eventId: String,
                            onSuccess: @escaping (_ success: Response.Events.RSVP) -> Void,
                            onError: @escaping (_ errorData: APIError) -> Void) {
        let builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/rsvp")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let rsvpResponse = JSONDecoder().decodeDict(of: Response.Events.RSVP.self, from: response) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(rsvpResponse)
        }, onError: onError)
    }

    /// Add user to event rsvp list
    ///
    /// - Parameters:
    ///   - request: struct with all needed parameters
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func addUserToRSVP(request: Request.Event.AddToRSVP,
                              onSuccess: @escaping (_ success: Bool) -> Void,
                              onError: @escaping (_ errorData: APIError) -> Void) {
        let builder = URLBuilder(client: client)
            .setPath("event/\(request.eventId)/rsvp")
            .addParameter(key: "usertoken", value: request.userToken)
        
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.POST(request: request,
                               parameters: [:],
                               onSuccess: { response in
            guard let success = response["success"] as? Bool else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(success)
        }, onError: onError)
    }

    /// Remove user from event rsvp list
    ///
    /// - Parameters:
    ///   - request: struct with all needed parameters
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func removeUserFromRSVP(request: Request.Event.RemoveFromRSVP,
                                   onSuccess: @escaping (_ success: Bool) -> Void,
                                   onError: @escaping (_ errorData: APIError) -> Void) {
        let builder = URLBuilder(client: client)
            .setPath("event/\(request.eventId)/rsvp")
            .addParameter(key: "usertoken", value: request.userToken)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.DELETE(request: request,
                                 parameters: [:],
                                 onSuccess: { response in

            guard let success = response["success"] as? Bool else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(success)
        }, onError: onError)
    }
}
