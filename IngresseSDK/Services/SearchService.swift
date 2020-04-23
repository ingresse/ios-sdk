//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class SearchService: BaseService {
    
    /// Search friends based on term (piece of name or exact email)
    ///
    /// - Parameters:
    ///   - userToken: token of logged user (required)
    ///   - queryString: term to search for
    ///   - limit: number of results
    ///   - onSuccess: success callback with User array
    ///   - onError: fail callback with APIError
    public func getFriends(_ userToken: String,
                           queryString: String,
                           limit: Int = 12,
                           onSuccess: @escaping (_ users: [User]) -> Void,
                           onError: @escaping (_ errorData: APIError) -> Void) {
        
        let str = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        let builder = URLBuilder(client: client)
            .setPath("search/transfer/user")
            .addParameter(key: "size", value: "\(limit)")
            .addParameter(key: "term", value: str)
            .addParameter(key: "usertoken", value: userToken)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in

            guard
                let data = response["data"] as? [[String: Any]],
                let users = JSONDecoder().decodeArray(of: [User].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            onSuccess(users)
        }, onError: onError)
    }

    /// Search events based on term
    ///
    /// - Parameters:
    ///   - eventTitle: title from required event search
    ///   - onSuccess: success callback with NewEvent array
    ///   - onError: fail callback with APIError
    public func getEvents(request: Request.Event.Search,
                          onSuccess: @escaping (_ event: [IngresseSDK.NewEvent], _ totalResults: Int) -> Void,
                          onError: @escaping (_ error: IngresseSDK.APIError) -> Void) {

        var builder = URLBuilder(client: client)
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "size", value: request.size)
            .addParameter(key: "from", value: request.from)
            .addParameter(key: "to", value: request.to)
            .addParameter(key: "orderBy", value: request.orderBy)
            .addParameter(key: "offset", value: request.offset)
        
        
        if !request.title.isEmpty {
            builder = builder.addParameter(key: "title", value: request.title)
        }

        if !request.description.isEmpty {
            builder = builder.addParameter(key: "description", value: request.description)
        }

        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }
        
        client.restClient.GET(request: request,
                              onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(events, total)
        }, onError: onError)
    }

    /// Search events based on id
    ///
    /// - Parameters:
    ///   - eventId: id from required event search
    public func getEvents(eventId: String,
                          onSuccess: @escaping (_ event: [IngresseSDK.NewEvent]) -> Void,
                          onError: @escaping (_ error: IngresseSDK.APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "id", value: eventId)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { (response) in
            guard
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(events)
        }, onError: onError)
    }
}
