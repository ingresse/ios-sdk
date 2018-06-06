//
//  TransfersService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public protocol TicketTransfersDelegate {
    func didDownloadPendingTransfers(_ transfers: [PendingTransfer], page: PaginationInfo)
    func didFailDownloadTransfers(errorData: APIError)
}

public class TransfersService: BaseService {
    
    /// Get users that recently received tickets from this user
    ///
    /// - Parameters:
    ///   - userID: id of logged user
    ///   - userToken: token of logged user (required)
    ///   - limit: number of items on response
    public func getRecentTransfers(userID: String, userToken: String, limit: Int = 12, onSuccess: @escaping (_ users: [User]) -> (), onError: @escaping (_ errorData: APIError) -> ()) {
        
        let url = URLBuilder(client: client)
            .setPath("user/\(userID)/last-transfers")
            .addParameter(key: "page", value: "1")
            .addParameter(key: "order", value: "desc")
            .addParameter(key: "pageSize", value: "\(limit)")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard let array = response["data"] as? [[String:Any]] else {
                onError(APIError.getDefaultError())
                return
            }

            let users = JSONDecoder().decodeArray(of: [User].self, from: array)

            onSuccess(users ?? [])
        }) { (error) in
            onError(error)
        }
    }
    
    /// Get pending transfers (invites user has not accepted yet)
    ///
    /// - Parameters:
    ///   - userID: id of logged user
    ///   - userToken: token of logged user (required)
    ///   - delegate: callback interface
    public func getPendingTransfers(_ userID: String, userToken: String, page: Int, delegate: TicketTransfersDelegate) {
        
        let url = URLBuilder(client: client)
            .setPath("user/\(userID)/transfers")
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "50")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any]
                else {
                    delegate.didFailDownloadTransfers(errorData: APIError.getDefaultError())
                    return
            }

            guard
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj),
                let transfers = JSONDecoder().decodeArray(of: [PendingTransfer].self, from: data)
                else {
                    delegate.didFailDownloadTransfers(errorData: APIError.getDefaultError())
                    return
            }
            
            delegate.didDownloadPendingTransfers(transfers, page: pagination)
        }) { (error) in
            delegate.didFailDownloadTransfers(errorData: error)
        }
    }
    
    /// Update transfer based on given action
    ///
    /// - Parameters:
    ///   - action: what should the resquest do: accept | refuse | cancel
    ///   - ticketID: id of ticket (not the code)
    ///   - userToken: token of logged user (required)
    public func updateTransfer(_ action: String, ticketID: String, transferID: String, userToken: String, onSuccess: @escaping () -> (), onError: @escaping (_ errorData: APIError) -> ()) {
        
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer/\(transferID)")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.POST(url: url, parameters: ["action":action], onSuccess: { (_) in
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
    
    /// Transfer ticket to some user
    ///
    /// - Parameters:
    ///   - ticketID: id of the ticket (not the code)
    ///   - userID: id of destination user
    ///   - userToken: token of logged user
    public func transferTicket(_ ticketID: String, toUser userID: String, userToken: String, onSuccess: @escaping (_ transfer: NewTransfer) -> (), onError: @escaping (_ errorData: APIError) -> ()) {
        
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.POST(url: url, parameters: ["user":userID], onSuccess: { (response) in
            guard let transfer = JSONDecoder().decodeDict(of: NewTransfer.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(transfer)
        }) { (error) in
            onError(error)
        }
    }
 
    /// Return ticket to last holder
    ///
    /// - Parameters:
    ///   - ticketID: id of the ticket (not the code)
    ///   - userToken: token of logged user
    public func returnTicket(_ ticketID: String, userToken: String, onSuccess: @escaping (_ ticketId: Int) -> (), onError: @escaping (_ errorData: APIError) -> ()) {
        
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.POST(url: url, parameters: ["isReturn":"true"], onSuccess: { (response) in
            guard let id = response["saleTicketId"] as? Int else {
                onError(APIError.getDefaultError())
                return
            }
            
            onSuccess(id)
        }) { (error) in
            onError(error)
        }
    }
}
