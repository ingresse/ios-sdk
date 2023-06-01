//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class AuthService: BaseService {

    /// Login by company
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - pass: password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    @objc public func companyLogin(_ email: String,
                                   andPassword pass: String,
                                   onSuccess: @escaping (_ response: [CompanyData]) -> Void,
                                   onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("company-login")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { response in
            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [[String: Any]],
            let companyArray = JSONDecoder().decodeArray(of: [CompanyData].self, from: data)
            else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(companyArray)
        }, onError: onError)
    }

    /// Login with email and password
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - pass: password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithEmail(
        _ email: String,
        andPassword pass: String,
        andDevice device: UserDevice,
        onSuccess: @escaping (_ response: IngresseUser) -> Void,
        onError: @escaping ErrorHandler
    ) {
        let builder = URLBuilder(client: client)
            .setPath("login/")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["email": email,
                      "password": pass]
        
        var header: [String: Any] = [:]
        if let jsonDevice = device.toJsonString() {
            header["X-INGRESSE-DEVICE"] = jsonDevice
        }

        client.restClient.POST(request: request,
                               parameters: params,
                               customHeader: header,
                               onSuccess: { response in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                onError(error)
                return
            }

            guard let data = response["data"] as? [String: Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let userData = IngresseUser.login(loginData: data)
            onSuccess(userData)
        }, onError: onError)
    }

    /// Login with facebook
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - fbToken: facebook access token
    ///   - fbUserId: facebook user id
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithFacebook(email: String,
                                  fbToken: String,
                                  fbUserId: String,
                                  andDevice device: UserDevice,
                                  onSuccess: @escaping (_ response: IngresseUser) -> Void,
                                  onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("login/facebook")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["email": email,
                      "fbToken": fbToken,
                      "fbUserId": fbUserId]
        
        var header: [String: Any] = [:]
        if let jsonDevice = device.toJsonString() {
            header["X-INGRESSE-DEVICE"] = jsonDevice
        }

        client.restClient.POST(request: request,
                               parameters: params,
                               customHeader: header,
                               onSuccess: { response in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [String: Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let userData = IngresseUser.login(loginData: data)
            onSuccess(userData)

        }, onError: onError)
    }

    /// Login with Apple
    ///
    /// - Parameters:
    ///   - userIdentifier: Apple userIdentifier
    ///   - identityToken: Apple identityToken
    ///   - authorizationCode: Apple authorizationCode
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithApple(userIdentifier: String,
                               identityToken: String,
                               authorizationCode: String,
                               andDevice device: UserDevice,
                               onSuccess: @escaping (_ response: IngresseUser) -> Void,
                               onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("login/apple")
        
        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        let params = ["userIdentifier": userIdentifier,
                      "identityToken": identityToken,
                      "authorizationCode": authorizationCode]
        
        var header: [String: Any] = [:]
        if let jsonDevice = device.toJsonString() {
            header["X-INGRESSE-DEVICE"] = jsonDevice
        }

        client.restClient.POST(request: request,
                               parameters: params,
                               customHeader: header,
                               onSuccess: { response in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [String: Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let userData = IngresseUser.login(loginData: data)
            onSuccess(userData)
        }, onError: onError)
    }

    /// Login with Facebank
    ///
    /// - Parameters:
    ///   - code: The code returner by Facebank's flow
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithFacebank(code: String,
                                  andDevice device: UserDevice,
                               onSuccess: @escaping (_ response: IngresseUser) -> Void,
                               onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client).setPath("login/facebank")
        
        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        let params = ["code": code,
                      "redirectUri": "ingresse://facebank"]
        
        var header: [String: Any] = [:]
        if let jsonDevice = device.toJsonString() {
            header["X-INGRESSE-DEVICE"] = jsonDevice
        }

        client.restClient.POST(request: request,
                               parameters: params,
                               customHeader: header,
                               onSuccess: { response in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [String: Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let userData = IngresseUser.login(loginData: data)
            onSuccess(userData)
        }, onError: onError)
    }

    /// Complete user data
    ///
    /// - Parameters:
    ///   - userId: Logged user's id
    ///   - userToken: Logged user's token
    ///   - fields: User attributes to get from API
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func getUserData(userId: String,
                            userToken: String,
                            fields: String? = nil,
                            onSuccess: @escaping (_ user: IngresseUser) -> Void,
                            onError: @escaping ErrorHandler) {
        let fieldsArray = [
            "id", "name", "lastname", "document", "email", "zip",
            "number", "complement", "city", "state", "street",
            "district", "ddi", "phone", "verified","fbUserId", "type",
            "pictures", "picture", "birthdate", "gender", "nationality"]
        let fieldsValue = fields ?? fieldsArray.joined(separator: ",")

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "fields", value: fieldsValue)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in

            guard let userData = JSONDecoder().decodeDict(of: UserData.self, from: response) else {

                return onError(APIError.getDefaultError())
            }

            let user = IngresseUser()
            user.data = userData
            user.userId = Int(userId) ?? -1
            user.token = userToken
            IngresseUser.user = user

            onSuccess(user)
        }, onError: onError)
    }

    /// Recover user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func recoverPassword(email: String,
                                onSuccess: @escaping () -> Void,
                                onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("recover-password")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["email": email]

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Validate recovery hash
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func validateHash(_ token: String,
                             email: String,
                             onSuccess: @escaping () -> Void,
                             onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("recover-validate")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        var params = ["email": email]
        params["hash"] = token

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Validate Incomplete User Token
    ///
    /// - Parameters:
    ///   - email: email of user to request activate account
    ///   - token: token received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func validateIncompleteUserToken(_ token: String,
                                            email: String,
                                            onSuccess: @escaping (String) -> Void,
                                            onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("activate-user-validate")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        var params = ["email": email]
        params["token"] = token

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { response in
            guard let status = response["status"] as? String else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(status)
        }, onError: onError)
    }

    /// Activate User
    ///
    /// - Parameters:
    ///   - email: email of user to request activate
    ///   - password: password to update
    ///   - token: token received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func activateUser(email: String,
                             password: String,
                             token: String,
                             onSuccess: @escaping (_ user: IngresseUser) -> Void,
                             onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("activate-user")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        var params = ["email": email]
        params["password"] = password
        params["token"] = token

        client.restClient.POST(request: request,
                               parameters: params,
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

    /// Update user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - password: password to update
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func updatePassword(email: String,
                               password: String,
                               token: String,
                               onSuccess: @escaping () -> Void,
                               onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("recover-update-password")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        var params = ["email": email]
        params["password"] = password
        params["hash"] = token

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Change profile password
    ///
    /// - Parameters:
    ///   - currentPassword: current user password
    ///   - newPassword: user new password
    ///   - token: user logged token
    ///   - userId: user logged id
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func changeProfilePassword(currentPassword: String,
                                      newPassword: String,
                                      token: String,
                                      userId: String,
                                      onSuccess: @escaping () -> Void,
                                      onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: token)

        var params = ["password": currentPassword]
        params["newPassword"] = newPassword

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.POST(request: request,
                               parameters: params,
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

            onSuccess()
        }, onError: onError)
    }
    
    /// Renew User Auth Token
    ///
    /// - Parameters:
    ///   - userToken: Logged user's token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func renewAuthToken(userToken: String,
                               onSuccess: @escaping (String) -> Void,
                               onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("/login/renew-token")
            .addParameter(key: "usertoken", value: userToken)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let authToken = response["authToken"] as? String else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(authToken)
        }, onError: onError)
    }

    /// Get Two Factor token for user
    ///
    /// - Parameters:
    ///   - deviceId: unique id of user's device
    ///   - otpCode: one time password, sent via sms
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func createTwoFactorToken(userToken: String,
                                     challenge: String?,
                                     deviceId: String,
                                     otpCode: String,
                                     onSuccess: @escaping (Response.Auth.TwoFactor) -> Void,
                                     onError: @escaping ErrorHandler) {

        var builder = URLBuilder(client: client)
            .setPath("two-factor")
            .addParameter(key: "usertoken", value: userToken)
        
        var params: [String: Any] = [:]
        if let challenge = challenge {
            builder = builder.addParameter(key: "challenge", value: challenge)
            params["challenge"] = challenge
        }

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let header = ["X-INGRESSE-OTP": otpCode, "X-INGRESSE-DEVICE": deviceId]
        client.restClient.POST(request: request,
                               parameters: params,
                               customHeader: header,
                               onSuccess: { response in

            guard let twoFactorResponse = JSONDecoder().decodeDict(of: Response.Auth.TwoFactor.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(twoFactorResponse)
        }, onError: onError)
    }
}
