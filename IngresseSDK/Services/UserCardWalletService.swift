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
                           onSuccess: @escaping (_ card: WalletInfoCreditCard) -> Void,
                           onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("wallet/creditcard")
            .addParameter(key: "usertoken", value: request.userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { response in

            guard let data = JSONDecoder().decodeDict(of: WalletInfoCreditCard.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(data)
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
            .setPath("wallet/creditcard/\(request.token)")
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
    public func deleteCard(userToken: String, uuid: String,
                           onSuccess: @escaping () -> Void,
                           onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("wallet/creditcard/\(uuid)")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.DELETE(request: request,
                                 parameters: [:],
                                 onSuccess: { _ in

            onSuccess()
        }, onError: onError)
    }
}
