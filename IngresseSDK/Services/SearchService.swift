//
//  SearchService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class SearchService: BaseService {
    
    /// Search friends based on term (piece of name or exact email)
    ///
    /// - Parameters:
    ///   - userToken: token of logged user (required)
    ///   - queryString: term to search for
    ///   - limit: number of results
    public func getFriends(_ userToken: String, queryString: String, limit: Int = 12, onSuccess: @escaping (_ users: [User]) -> (), onError: @escaping (_ errorData: APIError) -> ()) {
        
        let str = queryString.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        
        let url = URLBuilder(client: client)
            .setPath("search/transfer/user")
            .addParameter(key: "size", value: "\(limit)")
            .addParameter(key: "term", value: str)
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let users = JSONDecoder().decodeArray(of: [User].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            onSuccess(users)
        }) { (error) in
            onError(error)
        }
    }

    public func getSearch(searchTerm: String,
                          onSuccess: @escaping (_ event: [IngresseSDK.NewEvent], _ totalResults: Int)->(),
                          onError: @escaping (_ error: IngresseSDK.APIError)->()) {

        let categories = ["event", "featured", "festas_e_baladas", "universitario", "shows_e_festivais", "teatro"]
        //let page: ElasticPagination

        let url = URLBuilder(client: client)
            .setHost("https://hml-event.ingresse.com/")
            .setPath("search/company/1")
            //.addParameter(key: "state", value: place)
            //.addParameter(key: "size", value: page.size)
            //page.currentOffset)
            .buildWithoutKeys()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let total = response["total"] as? Int,
                let hits = response["hits"] as? [[String:Any]],
                let events = JSONDecoder().decodeArray(of: [NewEvent].self, from: hits)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            //var pagination = page
            //pagination.total = total

            onSuccess(events, total)
        }) { (error) in
            onError(error)
        }
    }
}
