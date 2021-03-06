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
    public func getEvents(fromUsertoken usertoken: String,
                          page: Int = 1,
                          delegate: UserEventsDownloaderDelegate) {

        let userId = usertoken.components(separatedBy: "-").first!

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)/events")
            .addParameter(key: "usertoken", value: usertoken)
            .addParameter(key: "page", value: String(page))
        guard let request = try? builder.build() else {

            return delegate.didFailDownloadEvents(errorData: APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let data = response["data"] as? [[String: Any]] else {
                delegate.didFailDownloadEvents(errorData: APIError.getDefaultError())
                return
            }

            delegate.didDownloadEvents(data)
        }, onError: delegate.didFailDownloadEvents)
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
    public func createAccount(request: Request.Auth.SignUp,
                              onSuccess: @escaping (_ user: IngresseUser) -> Void,
                              onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("user")
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        var requestWithCheck = request
        requestWithCheck.emailConfirm = requestWithCheck.email
        requestWithCheck.passCheck = requestWithCheck.password

        let data = try? JSONEncoder().encode(requestWithCheck)
        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { response in

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
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setPath("user/\(request.userId)")
            .addParameter(key: "usertoken", value: request.userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)

        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { response in

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
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["picture": String(format: "data:image/png;base64,%@", imageData)]

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Verify account with API
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - accountkitCode: code sent by accountkit
    ///   - onSuccess: success callback
    ///   - onError: fail callback with APIError
    public func verifyAccount(userId: Int,
                              userToken: String,
                              accountkitCode: String,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["accountkitCode": accountkitCode]

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["wallet"] as? [String: Any],
                let wallet = JSONDecoder().decodeDict(of: UserWalletInfo.self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(wallet)
        }, onError: onError)
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
        let builder = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: request.userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { _ in
            onSuccess()
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: request.userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)
        client.restClient.PUTData(request: requestURL,
                                  data: data,
                                  JSONData: true,
                                  onSuccess: { _ in
            onSuccess()
        }, onError: onError)
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

        let builder = URLBuilder(client: client)
            .setPath("wallet")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["token": token]

        client.restClient.DELETE(request: request,
                                 parameters: params,
                                 onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }
}
