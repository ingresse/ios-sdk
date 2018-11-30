//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentService: BaseService {
    /// Create Transaction
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - eventId: id of selected event
    ///   - tickets: tickets selected by user
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func createTransaction(request: Request.Shop.Create, userToken: String, onSuccess: @escaping (_ response: Response.Shop.Transaction) -> Void, onError: @escaping (_ error: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        guard let data = try? JSONEncoder().encode(request) else {
            onError(APIError.getDefaultError())
            return
        }

        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Transaction.self, from: newResponse) else {
                onError(APIError.getDefaultError())
                return
            }
            onSuccess(paymentResponse)
        }) { (error) in
            onError(error)
        }
    }

    /// Do free tickets reservation
    ///
    /// - Parameters:
    ///   - userToken: token of logged user
    ///   - request: struct with all needed parameters
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func doReserve(request: Request.Shop.Free, userToken: String, onSuccess: @escaping (_ response: Response.Shop.Payment) -> Void, onError: @escaping (_ error: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        guard let data = try? JSONEncoder().encode(request) else {
            onError(APIError.getDefaultError())
            return
        }

        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: { (error) in
            onError(error)
        })
    }


    /// Do payment tickets
    ///
    /// - Parameters:
    ///   - request: struct with all needed parameters
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func doPayment(request: Request.Shop.Payment, userToken: String, onSuccess: @escaping (_ response: Response.Shop.Payment) -> Void, onError: @escaping (_ error: APIError) -> Void) {
        let url = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        guard let data = try? JSONEncoder().encode(request) else {
            onError(APIError.getDefaultError())
            return
        }

        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Payment.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: { (error) in
            onError(error)
        })
    }
}
