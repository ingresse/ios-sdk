//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class UserService: BaseService {

    /// Get events using usertoken
    ///
    /// - Parameters:
    ///   - usertoken: token of logged user
    ///   - page: page of request
    ///   - delegate: callback interface
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

    /// Create user account
    ///
    /// - Parameters:
    ///   - name: user's name
    ///   - phone: user's phone number
    ///   - email: user's email
    ///   - password: password
    ///   - newsletter: defines if user wants to receive our newsletter
    ///   - onSuccess: success callback with IngresseUser
    ///   - onError: fail callback with APIError
    public func createAccount(name: String, phone: String, email: String, password: String, newsletter: Bool, onSuccess: @escaping (_ user: IngresseUser)->(), onError: @escaping (_ error: APIError)->()) {
        let url = URLBuilder(client: client)
            .setPath("user")
            .addParameter(key: "method", value: "create")
            .build()

        var params: [String:Any] = [:]

        var splitName = name.components(separatedBy: " ")
        if (splitName.count > 1) {
            params["lastname"] = splitName.last
            splitName.removeLast()
        }

        let firstName = splitName.joined(separator: " ")
        params["name"] = firstName
        params["phone"] = phone
        params["email"] = email
        params["emailConfirm"] = email
        params["password"] = password
        params["passCheck"] = password
        params["terms"] = true
        params["news"] = newsletter

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response) in
            guard let status = response["status"] as? Int else {
                onError(APIError.getDefaultError())
                return
            }

            if status == 0 {
                guard let message = response["message"] as? [String] else {
                    onError(APIError.getDefaultError())
                    return
                }

                let error = APIError.Builder()
                    .setCode(0)
                    .setTitle("Verifique suas informações")
                    .setMessage(message.joined(separator: "\n"))
                    .setResponse(response)
                    .build()

                onError(error)
                return
            }

            let data = response["data"] as! [String: Any]

            let _ = IngresseUser.login(loginData: data)
            IngresseUser.fillData(userData: data)

            onSuccess(IngresseUser.user!)
        }) { (error) in
            onError(error)
        }
    }

    /// Verify account with API
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - accountkitCode: code sent by accountkit
    ///   - onSuccess: success callback
    ///   - onError: fail callback with APIError
    public func verifyAccount(userId: Int, userToken: String, accountkitCode: String, onSuccess: @escaping ()->(), onError: @escaping (_ error: APIError)->()) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["accountkitCode": accountkitCode]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response) in
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
}
