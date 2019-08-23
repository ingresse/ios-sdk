//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class UserCardWalletService: BaseService {

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
        }, onError:  { (error) in
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
                           onSuccess: @escaping (_ card: WalletInfoCreditCard) -> Void,
                           onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("wallet/creditcard")
            .addParameter(key: "usertoken", value: request.userToken)
            .build()

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (_) in
            onSuccess()
        }) { (error) in
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
            .setPath("wallet/creditcard/\(request.token)")
            .addParameter(key: "usertoken", value: request.userToken)
            .build()

        let data = try? JSONEncoder().encode(request)

        client.restClient.PUTData(url: url, data: data, JSONData: true, onSuccess: { (_) in
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }

    /// Delete specific card from user wallet
    ///
    /// - Parameters:
    ///   - userToken: logged user token
    ///   - token: uuid from card
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func deleteCard(userToken: String, uuid: String,
                           onSuccess: @escaping () -> Void,
                           onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("wallet/creditcard/\(uuid)")
            .addParameter(key: "usertoken", value: userToken)
            .build()
            
        let params = ["token": token]
        let params = ["uuid": token]
        
        client.restClient.DELETE(url: url, parameters: params, onSuccess: { (_) in
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
}
