//
//  TransactionService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 6/29/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

@objc public protocol TransactionDownloadDelegate {
    func didDownloadTransaction(_ transactionInfo: Transaction)
    func transactionDownloadDidFail(errorData: APIError)
}

public class TransactionService: NSObject {
    
    var client: IngresseClient
    var delegate: TransactionDownloadDelegate!
    
    init(_ client: IngresseClient) {
        self.client = client
    }
    
    /// Download transaction data
    ///
    /// - Parameters:
    ///   - transactionId: id of the transaction
    ///   - userToken: user token required to make request
    ///
    ///   - delegate: callback listener
    public func getTransactionDetails(_ transactionId: String, userToken: String, delegate: TransactionDownloadDelegate) {
        let path = "sale/\(transactionId)"
        
        let params = ["usertoken": userToken]
        
        let url = URLBuilder.makeURL(host: client.host, path: path, publicKey: client.publicKey, privateKey: client.privateKey, parameters: params)
        
        client.restClient.GET(url: url) { (success: Bool, response: [String:Any]) in
            
            if !success {
                guard let error = response["error"] as? APIError else {
                    delegate.transactionDownloadDidFail(errorData: APIError.getDefaultError())
                    return
                }
                
                delegate.transactionDownloadDidFail(errorData: error)
                return
            }
            
            let transaction = Transaction()
            transaction.applyJSON(response)
            
            delegate.didDownloadTransaction(transaction)
        }
    }
}
