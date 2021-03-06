//
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
    ///   - onSuccess: success callback with User array
    ///   - onError: fail callback with APIError
    public func getRecentTransfers(userID: String,
                                   userToken: String,
                                   limit: Int = 12,
                                   onSuccess: @escaping (_ users: [Transfer]) -> Void,
                                   onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setPath("user/\(userID)/last-transfers")
            .addParameter(key: "page", value: "1")
            .addParameter(key: "order", value: "desc")
            .addParameter(key: "size", value: "\(limit)")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let array = response["data"] as? [[String: Any]],
                let users = JSONDecoder().decodeArray(of: [Transfer].self, from: array) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(users)
        }, onError: onError)
    }
    
    /// Get pending transfers (invites user has not accepted yet)
    ///
    /// - Parameters:
    ///   - userID: id of logged user
    ///   - userToken: token of logged user (required)
    ///   - delegate: callback interface
    public func getPendingTransfers(_ userID: String,
                                    userToken: String,
                                    page: Int,
                                    delegate: TicketTransfersDelegate) {
        
        let builder = URLBuilder(client: client)
            .setPath("user/\(userID)/transfers")
            .addParameter(key: "page", value: "\(page)")
            .addParameter(key: "pageSize", value: "50")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return delegate.didFailDownloadTransfers(errorData: APIError.getDefaultError())
        }
        
        client.restClient.GET(request: request, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let paginationObj = response["paginationInfo"] as? [String: Any],
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj),
                let transfers = JSONDecoder().decodeArray(of: [PendingTransfer].self, from: data)
                else {
                    delegate.didFailDownloadTransfers(errorData: APIError.getDefaultError())
                    return
            }
            
            delegate.didDownloadPendingTransfers(transfers, page: pagination)
        }, onError: delegate.didFailDownloadTransfers)
    }
    
    /// Update transfer based on given action
    ///
    /// - Parameters:
    ///   - action: what should the resquest do: accept | refuse | cancel
    ///   - ticketID: id of ticket (not the code)
    ///   - userToken: token of logged user (required)
    ///   - onSuccess: success callback
    ///   - onError: fail callback with APIError
    public func updateTransfer(_ action: String,
                               ticketID: String,
                               transferID: String,
                               userToken: String,
                               onSuccess: @escaping () -> Void,
                               onError: @escaping (_ errorData: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer/\(transferID)")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.POST(request: request,
                               parameters: ["action": action],
                               onSuccess: { _ in

            onSuccess()
        }, onError: onError)
    }
    
    /// Transfer ticket to some user
    ///
    /// - Parameters:
    ///   - ticketID: id of the ticket (not the code)
    ///   - userID: id of destination user
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback with NewTransfer
    ///   - onError: fail callback with APIError
    public func transferTicket(_ ticketID: String,
                               toUser userID: String,
                               userToken: String,
                               onSuccess: @escaping (_ transfer: NewTransfer) -> Void,
                               onError: @escaping (_ errorData: APIError) -> Void) {
        
        let builder = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.POST(request: request,
                               parameters: ["user": userID],
                               onSuccess: { response in

            guard let transfer = JSONDecoder().decodeDict(of: NewTransfer.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(transfer)
        }, onError: onError)
    }
 
    /// Return ticket to last holder
    ///
    /// - Parameters:
    ///   - ticketID: id of the ticket (not the code)
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback with ticketId
    ///   - onError: fail callback with APIError
    public func returnTicket(_ ticketID: String,
                             userToken: String,
                             onSuccess: @escaping (_ ticketId: Int) -> Void,
                             onError: @escaping (_ errorData: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setPath("ticket/\(ticketID)/transfer")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        
        client.restClient.POST(request: request,
                               parameters: ["isReturn": "true"],
                               onSuccess: { (response) in

            guard let id = response["saleTicketId"] as? Int else {
                onError(APIError.getDefaultError())
                return
            }
            
            onSuccess(id)
        }, onError: onError)
    }
}
