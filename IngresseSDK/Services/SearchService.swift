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
    public func getFriends(_ userToken: String, queryString: String, limit: Int = 12, onSuccess: @escaping (_ users: [User]) -> Void, onError: @escaping (_ errorData: APIError) -> Void) {
        
        let str = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        let url = URLBuilder(client: client)
            .setPath("search/transfer/user")
            .addParameter(key: "size", value: "\(limit)")
            .addParameter(key: "term", value: str)
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let users = JSONDecoder().decodeArray(of: [User].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            onSuccess(users)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Search events based on term
    ///
    /// - Parameters:
    ///   - eventTitle: title from required event search
    ///   - onSuccess: success callback with NewEvent array
    ///   - onError: fail callback with APIError
    public func getEvents(filters: [String: String],
                          onSuccess: @escaping (_ event: [IngresseSDK.NewEvent], _ totalResults: Int) -> Void,
                          onError: @escaping (_ error: IngresseSDK.APIError) -> Void) {

        var builder = URLBuilder(client: client)
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "size", value: "20")
            .addParameter(key: "from", value: "now-6h")
            .addParameter(key: "orderBy", value: "sessions.dateTime")
            .addParameter(key: "offset", value: "0")

        for (key, value) in filters {
            builder = builder.addParameter(key: key, value: value)
        }

        let url = builder.buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(events, total)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Search events based on id
    ///
    /// - Parameters:
    ///   - eventId: id from required event search
    public func getEvents(eventId: String,
                          onSuccess: @escaping (_ event: [IngresseSDK.NewEvent]) -> Void,
                          onError: @escaping (_ error: IngresseSDK.APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setHost(.search)
            .setPath("1")
            .addParameter(key: "id", value: eventId)
            .buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let hits = response["hits"] as? [[String: Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(events)
        }, onError: { (error) in
            onError(error)
        })
    }
}
