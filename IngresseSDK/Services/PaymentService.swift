//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentService: BaseService {
    /// Do free tickets reservation
    ///
    /// - Parameters:
    ///   - userToken: token of logged user
    ///   - request: struct with all needed parameters
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func doReserve(request: Request.Shop.Free,
                          userToken: String,
                          onSuccess: @escaping (_ response: Response.Shop.Payment) -> Void,
                          onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { response in

            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: onError)
    }

    /// Do payment tickets
    ///
    /// - Parameters:
    ///   - request: struct with all needed parameters
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func doPayment(request: Request.Shop.Payment,
                          userToken: String,
                          onSuccess: @escaping (_ response: Response.Shop.Payment) -> Void,
                          onError: @escaping ErrorHandler) {
        let builder = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(request: requestURL,
                                   data: data,
                                   JSONData: true,
                                   onSuccess: { response in

            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: onError)
    }
}
