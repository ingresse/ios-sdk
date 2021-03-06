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
    public func createTransaction(request: Request.Shop.Create,
                                  userToken: String,
                                  onSuccess: @escaping (_ response: Response.Shop.Transaction) -> Void,
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
                let paymentResponse = JSONDecoder().decodeDict(of: Response.Shop.Transaction.self, from: newResponse) else {
                    onError(APIError.getDefaultError())
                    return
            }
            onSuccess(paymentResponse)
        }, onError: onError)
    }

    /// Get transaction details
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - userToken: user Token
    ///   - onSuccess: success callback with Transaction
    ///   - onError: fail callback with APIError
    @objc public func getTransactionDetails(_ transactionId: String,
                                            userToken: String,
                                            onSuccess: @escaping (_ transaction: TransactionData) -> Void,
                                            onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("sale/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            let transaction = JSONDecoder().decodeDict(of: TransactionData.self, from: response)!
            onSuccess(transaction)
        }, onError: onError)
    }

    /// Update a transaction
    ///
    /// - Parameters:
    ///     - transactinId: transaction id
    ///     - insured: ticket insurance hired or not
    ///     - userToken: user token
    ///     - onSuccess: empty success callback
    ///     - onError: fail callback with APIError
    public func updateTransaction(_ transactionId: String,
                                  insured: Bool,
                                  userToken: String,
                                  onSuccess: @escaping () -> Void,
                                  onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["insured": insured]
        let data = try? JSONEncoder().encode(params)

        client.restClient.PUTData(request: request,
                                  data: data,
                                  JSONData: true,
                                  onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Cancel transaction
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - onSuccess: success callback with Transaction
    ///   - onError: fail callback with APIError
    public func cancelTransaction(_ transactionId: String,
                                  userToken: String,
                                  onSuccess: @escaping () -> Void,
                                  onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)/cancel")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.POST(request: request,
                               onSuccess: { _ in
            onSuccess()
        }, onError: onError)
    }

    /// Get payment methods from some transaction
    ///
    /// - Parameters:
    ///     - transactionId: transaction id
    ///     - onSuccess: success callback with payment methods
    ///     - onError: fail callback with APIError
    public func getPaymentMethods(_ transactionId: String,
                                  userToken: String,
                                  onSuccess: @escaping (_ methods: Response.Shop.Methods) -> Void,
                                  onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)/payment-methods")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard let methods = JSONDecoder().decodeDict(of: Response.Shop.Methods.self, from: response)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(methods)
        }, onError: onError)
    }

    /// Get status from user tickets
    ///
    /// - Parameters:
    ///   - ticketCode: ticket code
    ///   - userToken: user Token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getCheckinStatus(_ ticketCode: String,
                                 userToken: String,
                                 onSuccess: @escaping (_ checkinSession: [CheckinSession]) -> Void,
                                 onError: @escaping ErrorHandler) {

        let ticket: String = ticketCode.stringWithPercentEncoding()!
        let builder = URLBuilder(client: client)
            .setPath("ticket/\(ticket)/status")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let checkinSession = JSONDecoder().decodeArray(of: [CheckinSession].self, from: data) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(checkinSession)
        }, onError: onError)
    }

    /// Apply coupom in transaction
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - code: coupom code
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func applyCouponToPayment(transactionId: String, code: String, userToken: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        
        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)/coupon")
            .addParameter(key: "usertoken", value: userToken)
        
        guard let requestURL = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        let params = ["code": code]

        client.restClient.POST(request: requestURL, parameters: params, onSuccess: { (_) in
            onSuccess()
        }, onError: onError)
    }

    public func removeCouponToPayment(transactionId: String, userToken: String, onSuccess: @escaping () -> Void, onError: @escaping ErrorHandler) {
        
        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)/coupon")
            .addParameter(key: "usertoken", value: userToken)
        
        guard let requestURL = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        client.restClient.DELETE(request: requestURL, parameters: [:], onSuccess: { (_) in
            onSuccess()
        }, onError: onError)
    }

    /// Update a transaction with coupon
    ///
    /// - Parameters:
    ///     - transactinId: transaction id
    ///     - userToken: user token
    ///     - onSuccess: success callback
    ///     - onError: fail callback with APIError
    public func updateTransactionWithCoupon(_ transactionId: String, userToken: String, onSuccess: @escaping (_ transaction: TransactionData) -> Void, onError: @escaping ErrorHandler) {
        
        let builder = URLBuilder(client: client)
            .setPath("shop/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)
        
        guard let requestURL = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }
 
        client.restClient.GET(request: requestURL, onSuccess: { (response) in
             guard let transaction = JSONDecoder().decodeDict(of: TransactionData.self, from: response) else {
                    onError(APIError.getDefaultError())
                    return
             }
             onSuccess(transaction)
        }, onError: onError)
    }
        
    public func getUserWalletTransactions(request: Request.Transaction.UserTransaction,
                                          onSuccess: @escaping (_ transactions: [UserWalletTransaction], _ page: Int, _ lastPage: Int) -> Void,
                                          onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setHost(.userTransactions)
            .addParameter(key: "channel", value: request.channel)
            .addParameter(key: "status", value: request.status)
            .addParameter(key: "pageSize", value: request.pageSize)
            .addParameter(key: "page", value: request.page)
        guard let requestURL = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.GET(request: requestURL,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let checkinSession = JSONDecoder().decodeArray(of: [UserWalletTransaction].self, from: data),
                let paginationData = response["paginationInfo"] as? [String: Any],
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationData) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(checkinSession, pagination.currentPage, pagination.lastPage)
        }, onError: onError)
    }
    
    public func refundUserTransactions(transactionId: String,
                                       onSuccess: @escaping () -> Void,
                                       onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setHost(.userTransactions)
            .setPath("\(transactionId)/refund")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.POST(request: request,
                               parameters: [:],
                               customHeader: [:],
                               onSuccess: { _ in
                                onSuccess()
        }, onError: onError)
    }
}
