//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionService: BaseService {

    /// Get transaction details
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - userToken: user Token
    ///   - onSuccess: success callback with Transaction
    ///   - onError: fail callback with APIError
    public func getTransactionDetails(_ transactionId: String, userToken: String, onSuccess: @escaping (_ transaction: Transaction)->(), onError: @escaping (_ error: APIError) -> ()) {

        let url = URLBuilder(client: client)
            .setPath("sale/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            let transaction = JSONDecoder().decodeDict(of: Transaction.self, from: response)!
            onSuccess(transaction)
        }) { (error) in
            onError(error)
        }
    }

    /// Get status from user tickets
    ///
    /// - Parameters:
    ///   - ticketCode: ticket code
    ///   - userToken: user Token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getCheckinStatus(_ ticketCode: String, userToken: String, onSuccess: @escaping (_ checkinSession: [CheckinSession])->(), onError: @escaping (_ error: APIError) -> ()) {
        let ticket: String = ticketCode.stringWithPercentEncoding()!
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticket)/status")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let checkinSession = JSONDecoder().decodeArray(of: [CheckinSession].self, from: data) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(checkinSession)
        }) { (error) in
            onError(error)
        }
    }
}
