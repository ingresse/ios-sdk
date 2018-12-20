//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionService: BaseService {
    /// Create Transaction
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - eventId: id of selected event
    ///   - tickets: tickets selected by user
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func createTransaction(request: Request.Shop.Create, userToken: String, onSuccess: @escaping (_ response: Response.Shop.Transaction) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("shop")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let data = try? JSONEncoder().encode(request)
        client.restClient.POSTData(url: url, data: data, JSONData: true, onSuccess: { (response) in
            guard let newResponse = response["data"] as? [String: Any],
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Transaction.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get transaction details
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - userToken: user Token
    ///   - onSuccess: success callback with Transaction
    ///   - onError: fail callback with APIError
    public func getTransactionDetails(_ transactionId: String, userToken: String, onSuccess: @escaping (_ transaction: TransactionData) -> Void, onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("sale/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            let transaction = JSONDecoder().decodeDict(of: TransactionData.self, from: response)!
            onSuccess(transaction)
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Cancel transaction
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - onSuccess: success callback with Transaction
    ///   - onError: fail callback with APIError
    public func cancelTransaction(_ transactionId: String, userToken: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("shop/\(transactionId)/cancel")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.POST(url: url, parameters: [:], onSuccess: { (response) in
            onSuccess()
        }, onError: { (error) in
            onError(error)
        })
    }

    /// Get status from user tickets
    ///
    /// - Parameters:
    ///   - ticketCode: ticket code
    ///   - userToken: user Token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getCheckinStatus(_ ticketCode: String, userToken: String, onSuccess: @escaping (_ checkinSession: [CheckinSession]) -> Void, onError: @escaping ErrorHandler) {
        let ticket: String = ticketCode.stringWithPercentEncoding()!
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticket)/status")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let checkinSession = JSONDecoder().decodeArray(of: [CheckinSession].self, from: data) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(checkinSession)
        }, onError: { (error) in
            onError(error)
        })
    }
}
