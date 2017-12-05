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
            guard let data = response["data"] as? [[String:Any]] else {
                onError(APIError.getDefaultError())
                return
            }
            
            var users = [User]()
            for obj in data {
                let user = User()
                user.applyJSON(obj)
                users.append(user)
            }
            
            onSuccess(users)
        }) { (error) in
            onError(error)
        }
    }
}
