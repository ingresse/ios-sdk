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
}
