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
            guard let data = response["data"] as? [[String: Any]] else {
                delegate.didFailDownloadEvents(errorData: APIError.getDefaultError())
                return
            }

            delegate.didDownloadEvents(data)
        }, onError: { (error) in
            delegate.didFailDownloadEvents(errorData: error)
        })
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
    public func createAccount(request: Request.Auth.SignUp, onSuccess: @escaping (_ user: IngresseUser) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("user")
            .build()

        var requestWithCheck = request
        requestWithCheck.emailConfirm = requestWithCheck.email
        requestWithCheck.passCheck = requestWithCheck.password

        let data = try? JSONEncoder().encode(requestWithCheck)
        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
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

            _ = IngresseUser.login(loginData: data)
            IngresseUser.fillData(userData: data)

            onSuccess(IngresseUser.user!)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Update basic infos
    ///
    /// - Parameters:
    ///   - userId: logged user id
    ///   - userToken: logged user token
    ///   - name: new user name
    ///   - lastname: new user lastname
    ///   - email: new user email
    ///   - ddi: new user ddi
    ///   - phone: new user phone
    ///   - cpf: new user cpf
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func updateBasicInfos(request: Request.UpdateUser.BasicInfos,
                                 onSuccess: @escaping (_ user: UpdatedUser) -> Void,
                                 onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("user/\(request.userId)")
            .addParameter(key: "usertoken", value: request.userToken)
            .build()

        let data = try? JSONEncoder().encode(request)

        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
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

            let userUpdated = JSONDecoder().decodeDict(of: UpdatedUser.self, from: response["data"] as! [String: Any])!
            onSuccess(userUpdated)
        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Change user picture
    ///
    /// - Parameters:
    ///   - userId: logged user id
    ///   - userToken: logged user token
    ///   - imageData: data from new user picture
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func changePicture(userId: String,
                              userToken: String,
                              imageData: String,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["picture": String(format: "data:image/png;base64,%@", imageData)]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (_) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Verify account with API
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - accountkitCode: code sent by accountkit
    ///   - onSuccess: success callback
    ///   - onError: fail callback with APIError
    public func verifyAccount(userId: Int, userToken: String, accountkitCode: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["accountkitCode": accountkitCode]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (_) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get user wallet infos
    ///
    /// - Parameters:
    ///   - userToken: logged user token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getUserWalletInfos(userToken: String,
                                   onSuccess: @escaping (_ walletInfo: UserWalletInfo) -> Void,
                                   onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
        .setPath("wallet")
        .addParameter(key: "usertoken", value: userToken)
        .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["wallet"] as? [String: Any],
                let wallet = JSONDecoder().decodeDict(of: UserWalletInfo.self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(wallet)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    /// Insert new card in user wallet
    ///
    /// - Parameters:
    ///   - userToken: logged user token
    ///   - cvv: credit card attribute
    ///   - expiration: credit card attribute
    ///   - holder: credit card attribute
    ///   - number: credit card attribute
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func insertCard(_ request: Request.UserCardWallet.Insertion,
                           onSuccess: @escaping () -> Void,
                           onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: request.userToken)
            .build()

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (_) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Change the default card from user wallet
    ///
    /// - Parameters:
    ///   - userToken: logged user token
    ///   - token: uuid from card
    ///   - cardDefault: true or false
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func changeDefaultCard(_ request: Request.UserCardWallet.Managment,
                                  onSuccess: @escaping () -> Void,
                                  onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: request.userToken)
            .build()

        let data = try? JSONEncoder().encode(request)
        client.restClient.PUTData(url: url, data: data, JSONData: true, onSuccess: { (_) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Delete specific card from user wallet
    ///
    /// - Parameters:
    ///   - userToken: logged user token
    ///   - token: uuid from card
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func deleteCard(userToken: String, token: String,
                           onSuccess: @escaping () -> Void,
                           onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["token": token]

        client.restClient.DELETE(url: url, parameters: params, onSuccess: { (_) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }
}
