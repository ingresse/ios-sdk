//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionService: BaseService {

    /// Create transaction to get id for payment or reserve
    ///
    /// - Parameters:
    ///   - userToken: token of logged user
    ///   - userId: id of logged user
    ///   - eventId: id of selected event
    ///   - passkey: passkey
    ///   - sessionTickets: all tickets for transaction
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func createTransaction(userId: String,
                                  userToken: String,
                                  eventId: String,
                                  passkey: String?,
                                  sessionTickets: [ShopTicket],
                                  onSuccess: @escaping (_ transaction: String) -> Void, onError: @escaping ErrorHandler) {

        let url = URLBuilder(client: client)
            .setPath("shop/")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        var params: [String: Any] = ["eventId": eventId,
                                     "userId": userId]

        if passkey != nil && !passkey!.isEmpty {
            params["passkey"] = passkey
        }

        var ticketIndex = 0
        for ticket: ShopTicket in sessionTickets where ticket.quantity > 0 {
            params["tickets[\(ticketIndex)][guestTypeId]"] = ticket.guestTypeId
            params["tickets[\(ticketIndex)][quantity]"] = ticket.quantity
            ticketIndex += 1
        }

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response) in
            guard
                let responseData = response["data"] as? [String: Any],
                let transaction = responseData["transactionId"] as? String else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(transaction)
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
