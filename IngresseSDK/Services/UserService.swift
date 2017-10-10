//
//  UserService.swift
//  IngresseSDK
//
//  Created by Marcelo Bissuh on 20/07/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

@objc public protocol UserEventsDownloaderDelegate {

    func didDownloadEvents(_ userEvents: [[String: Any]])
    func didFailDownloadEvents(errorData: APIError)

}

public class UserService: BaseService {

    public func getEvents(fromUsertoken usertoken: String, page: Int = 1, delegate: UserEventsDownloaderDelegate) {

        let userId = usertoken.components(separatedBy: "-").first!

        let url = URLBuilder(client: client)
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

    /**
     Get user information
     - parameter userId: User ID
     - parameter userToken: User token, when performing the request as logged user. Optional.
     - parameter completion: Callback block
     */
    public func getUser(userId:Int, userToken: String = "", completion: @escaping (_ success: Bool, _ response:User?)->()) {

        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "fields", value: "id,name,lastname,email,pictures")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response: [String:Any]) in

            let user = User()
            user.applyJSON(response)
            completion(true, user)

        }) { (error: APIError) in

            completion(false, nil)

        }
    }}
