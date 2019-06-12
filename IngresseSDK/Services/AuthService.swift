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
    @objc public func companyLogin(_ email: String, andPassword pass: String, onSuccess: @escaping (_ response: [CompanyData]) -> Void, onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("company-login")
            .build()

        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
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

        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Login with email and password
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - pass: password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithEmail(_ email: String, andPassword pass: String, onSuccess: @escaping (_ response: IngresseUser) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("login/")
            .build()

        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in

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

            let user = IngresseUser.login(loginData: data)

            self.getUserData(
                userId: String(user.userId),
                userToken: user.token,
                onSuccess: { (userData) in
                    userData.authToken = user.authToken
                    onSuccess(userData)
            }, onError: { (error) in onError(error) })

        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Login with facebook
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - fbToken: facebook access token
    ///   - fbUserId: facebook user id
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithFacebook(email: String, fbToken: String, fbUserId: String, onSuccess: @escaping (_ response: IngresseUser) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("login/facebook")
            .build()

        let params = ["email": email,
                      "fbToken": fbToken,
                      "fbUserId": fbUserId]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in

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

            let user = IngresseUser.login(loginData: data)

            self.getUserData(
                userId: String(user.userId),
                userToken: user.token,
                onSuccess: { (userData) in
                    userData.authToken = user.authToken
                    onSuccess(userData)
            }, onError: { (error) in onError(error) })

        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Complete user data
    ///
    /// - Parameters:
    ///   - userId: Logged user's id
    ///   - userToken: Logged user's token
    ///   - fields: User attributes to get from API
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func getUserData(userId: String, userToken: String, fields: String? = nil, onSuccess: @escaping (_ user: IngresseUser) -> Void, onError: @escaping ErrorHandler) {
        let fieldsArray = [
            "id", "name", "lastname",
            "document", "email", "zip",
            "number", " complement", "city",
            "state", "street", "district",
            "phone", "verified", "fbUserId",
            "type", "pictures", "picture"]
        let fieldsValue = fields ?? fieldsArray.joined(separator: ",")

        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "fields", value: fieldsValue)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response: [String: Any]) in
            let userData = JSONDecoder().decodeDict(of: UserData.self, from: response)!

            let user = IngresseUser()
            user.data = userData
            user.userId = Int(userId) ?? -1
            user.token = userToken
            IngresseUser.user = user

            onSuccess(user)
        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Recover user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func recoverPassword(email: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("recover-password")
            .build()

        let params = ["email": email]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Validate recovery hash
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func validateHash(_ token: String, email: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("recover-validate")
            .build()

        var params = ["email": email]
        params["hash"] = token

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }, onError: { (error: APIError) in
            onError(error)
        })
    }

    /// Update user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - password: password to update
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func updatePassword(email: String, password: String, token: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("recover-update-password")
            .build()

        var params = ["email": email]
        params["password"] = password
        params["hash"] = token

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }, onError: { (error: APIError) in
            onError(error)
        })
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
    public func changeProfilePassword(currentPassword: String, newPassword: String, token: String, userId: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: token)
            .build()

        var params = ["password": currentPassword]
        params["newPassword"] = newPassword

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
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
        }, onError: { (error: APIError) in
            onError(error)
        })
    }
    
    /// Renew User Auth Token
    ///
    /// - Parameters:
    ///   - userToken: Logged user's token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func renewAuthToken(userToken: String, onSuccess: @escaping (String) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("/login/renew-token")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { response in
            guard let authToken = response["authToken"] as? String else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(authToken)
        }, onError: { (error) in
            onError(error)
        })
    }

    public func createTwoFactorToken(deviceId: String, otpCode: String, onSuccess: @escaping (Response.Auth.TwoFactor) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("two-step")
            .build()

        let header = ["X-INGRESSE-OTP": otpCode, "X-INGRESSE-DEVICE": deviceId]
        client.restClient.POST(url: url, parameters: [:], customHeader: header, onSuccess: { response in
            guard let twoFactorResponse = JSONDecoder().decodeDict(of: Response.Auth.TwoFactor.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(twoFactorResponse)
        }, onError: { (error) in
            onError(error)
        })
    }
}
