//
//  UserService.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 20/07/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

@objc public protocol UserEventsDownloaderDelegate {
    
    func didDownloadEvents(_ userEvents: [[String: Any]])
    func didFailDownloadEvents(errorData: APIError)
    
}

public class UserService: NSObject {

    var client: IngresseClient
    
    init(_ client:IngresseClient) {
        self.client = client
    }
    
    public func getEvents(fromUsertoken usertoken: String, page: Int = 1, delegate: UserEventsDownloaderDelegate) {
        
        let userId = usertoken.components(separatedBy: "-").first!
        
        let url = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("user/\(userId)/events")
            .addParameter(key: "usertoken", value: usertoken)
            .addParameter(key: "page", value: String(page))
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let data = response["data"] as? [[String:Any]] else {
                delegate.didFailDownloadEvents(errorData: APIError.getDefaultError())
                return
            }
            
            delegate.didDownloadEvents(data)
        }) { (error) in
            delegate.didFailDownloadEvents(errorData: error)
        }
    }
    
}
