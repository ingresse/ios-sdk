//
//  TransactionService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionService: NSObject {
    
    var client: IngresseClient
    
    init(_ client: IngresseClient) {
        self.client = client
    }
    
    /// Get transaction details
    ///
    /// - Parameters:
    ///   - transactionId: transaction id
    ///   - userToken: user Token
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getTransactionDetails(_ transactionId: String, userToken: String, onSuccess: @escaping (_ transaction: Transaction)->(), onError: @escaping (_ error: APIError) -> ()) {
        
        let url = URLBuilder()
            .setKeys(publicKey: client.publicKey, privateKey: client.privateKey)
            .setHost(client.host)
            .setPath("sale/\(transactionId)")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            let transaction = Transaction()
            transaction.applyJSON(response)
            
            onSuccess(transaction)
        }) { (error) in
            onError(error)
        }
    }
}
