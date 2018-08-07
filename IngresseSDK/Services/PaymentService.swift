//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class PaymentService: BaseService {


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
            let newResponse = response["data"] as! [String:Any]
            let paymentResponse = JSONDecoder().decodeDict(of: PaymentResponse.self, from: newResponse)!
            onSuccess(paymentResponse)
        }) { (error) in
            onError(error)
        }
    }
}
