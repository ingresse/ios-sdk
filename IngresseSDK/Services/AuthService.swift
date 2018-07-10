//
//  AuthService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

/// Login by company
///
/// - Parameters:
///   - email: user's email
///   - pass: password
///   - onSuccess: Success callback
///   - onError: Fail callback
public class AuthService: BaseService {

    public func companyLogin(_ email: String, andPassword pass: String, onSuccess: @escaping (_ response: [CompanyData]) -> (), onError: @escaping (_ error: APIError) -> ()) {

        let url = URLBuilder(client: client)
            .setPath("company-login")
            .build()

        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String:Any]) in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [[String:Any]],
            let companyArray = JSONDecoder().decodeArray(of: [CompanyData].self, from: data)
            else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(companyArray)

        }) { (error: APIError) in
            onError(error)
        }
    }

    /// Login with email and password
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - pass: password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithEmail(_ email: String, andPassword pass: String, onSuccess: @escaping (_ response: IngresseUser) -> (), onError: @escaping (_ error: APIError) -> ()) {
        
        let url = URLBuilder(client: client)
            .setPath("login/")
            .build()
        
        let params = ["email": email,
                      "password": pass]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String:Any]) in
            
            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                onError(error)
                return
            }

            guard let data = response["data"] as? [String:Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let user = IngresseUser.login(loginData: data)

            self.getUserData(
                userId: String(user.userId),
                userToken: user.token,
                onSuccess: { (user) in onSuccess(user) },
                onError: { (error) in onError(error) })

        }) { (error: APIError) in
            onError(error)
        }
    }

    /// Login with facebook
    ///
    /// - Parameters:
    ///   - email: user's email
    ///   - fbToken: facebook access token
    ///   - fbUserId: facebook user id
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func loginWithFacebook(email: String, fbToken: String, fbUserId: String, onSuccess: @escaping (_ response: IngresseUser) -> (), onError: @escaping (_ error: APIError) -> ()) {

        let url = URLBuilder(client: client)
            .setPath("login/facebook")
            .build()

        let params = ["email": email,
                      "fbToken": fbToken,
                      "fbUserId": fbUserId]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String:Any]) in

            guard let logged = response["status"] as? Bool,
                logged else {
                    let error = APIError.Builder()
                        .setCode(-1)
                        .setError(response["message"] as! String)
                        .build()

                    onError(error)
                    return
            }

            guard let data = response["data"] as? [String:Any] else {
                onError(APIError.getDefaultError())
                return
            }

            let user = IngresseUser.login(loginData: data)

            self.getUserData(
                userId: String(user.userId),
                userToken: user.token,
                onSuccess: { (user) in onSuccess(user) },
                onError: { (error) in onError(error) })

        }) { (error: APIError) in
            onError(error)
        }
    }
    
    /// Complete user data
    ///
    /// - Parameters:
    ///   - userId: Logged user's id
    ///   - userToken: Logged user's token
    ///   - fields: User attributes to get from API
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func getUserData(userId: String, userToken: String, fields: String? = nil, onSuccess: @escaping (_ user:IngresseUser)->(), onError: @escaping (_ error: APIError)->()) {
        
        let fieldsValue = fields ?? "id,name,lastname,email,zip,number,complement,city,state,street,district,phone,verified,fbUserId,type"
        
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "fields", value: fieldsValue)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response: [String:Any]) in
            guard let data = response as? [String:Any],
                let userData = JSONDecoder().decodeDict(of: UserData.self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            let user = IngresseUser()
            user.data = userData
            user.userId = Int(userId) ?? -1
            user.token = userToken
            IngresseUser.user = user

            onSuccess(user)
            
        }) { (error: APIError) in
            onError(error)
        }
    }

    /// Recover user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func recoverPassword(email: String, onSuccess: @escaping ()->(), onError: @escaping (_ error: APIError)->()) {

        let url = URLBuilder(client: client)
            .setPath("recover-password")
            .build()

        let params = ["email":email]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }) { (error: APIError) in
            onError(error)
        }
    }

    /// Validate recovery hash
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func validateHash(_ token: String, email: String, onSuccess: @escaping ()->(), onError: @escaping errorHandler) {

        let url = URLBuilder(client: client)
            .setPath("recover-validate")
            .build()

        var params = ["email": email]
        params["hash"] = token

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }) { (error: APIError) in
            onError(error)
        }
    }

    /// Update user password
    ///
    /// - Parameters:
    ///   - email: email of user to request password
    ///   - password: password to update
    ///   - token: hash received from email
    ///   - onSuccess: Success callback
    ///   - onError: Fail callback
    public func updatePassword(email: String, password: String, token: String, onSuccess: @escaping ()->(), onError: @escaping (_ error: APIError)->()) {

        let url = URLBuilder(client: client)
            .setPath("recover-update-password")
            .build()

        var params = ["email": email]
        params["password"] = password
        params["hash"] = token

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response: [String: Any]) in
            onSuccess()
        }) { (error: APIError) in
            onError(error)
        }
    }
}
