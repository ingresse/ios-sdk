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
    public func createTransaction(userId: String, userToken: String, eventId: String, tickets: [PaymentTicket], onSuccess: @escaping (_ response: Transaction) -> Void, onError: @escaping (_ error: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("shop/")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = StartTransaction(userId: userId, eventId: eventId, tickets: tickets)
        guard
            let data = try? JSONEncoder().encode(params) else {
                onError(APIError.getDefaultError())
                return
        }

        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
            guard
                let newResponse = response["data"] as? [String:Any] else {
                    onError(APIError.getDefaultError())
                    return
            }
            let paymentResponse = JSONDecoder().decodeDict(of: Transaction.self, from: newResponse)!
            onSuccess(paymentResponse)
        }) { (error) in
            onError(error)
        }
    }

    /// Do free tickets reserve
    ///
    /// - Parameters:
    ///   - userToken: token of logged user
    ///   - userId: id of logged user
    ///   - document: cpf of logged user
    ///   - eventId: id of selected event
    ///   - postback: postback
    ///   - transactionId: id of transaction
    ///   - ingeprefsPayload: ingeprefsPayload
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func doReserve(userToken: String, userId: String, document: String, eventId: String, postback: String,
                          transactionId: String, ingeprefsPayload: String, onSuccess: @escaping (_ response: PaymentResponse) -> Void, onError: @escaping (_ error: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("shop/")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["userId" : userId,
                      "document" : document,
                      "eventId" : eventId,
                      "postback" : postback,
                      "transactionId" : transactionId,
                      "ingeprefsPayload" : ingeprefsPayload]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response) in
            guard
                let newResponse = response["data"] as? [String:Any] else {
                    onError(APIError.getDefaultError())
                    return
            }
            let paymentResponse = JSONDecoder().decodeDict(of: PaymentResponse.self, from: newResponse)!
            onSuccess(paymentResponse)
        }) { (error) in
            onError(error)
        }
    }
}
