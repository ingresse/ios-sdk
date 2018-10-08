//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class MyTicketsService: BaseService {
    
    /// Get sessions user has tickets to
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserWallet(userId: String, userToken: String, page: Int, delegate: WalletSyncDelegate) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)/wallet")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any],
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj),
                let items = JSONDecoder().decodeArray(of: [WalletItem].self, from: data)
                else {
                    delegate.didFailSyncItems(errorData: APIError.getDefaultError())
                    return
            }

            delegate.didSyncItemsPage(items, pagination: pagination)
        }) { (error) in
            delegate.didFailSyncItems(errorData: error)
        }
    }

    /// Get all tickets user has
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - eventId: id of requested event
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserTickets(userId: String, eventId: String, userToken: String, page: Int, delegate: TicketSyncDelegate) {
        let url = URLBuilder(client: client)
            .setPath("user/\(userId)/tickets")
            .addParameter(key: "eventId", value: eventId)
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .addParameter(key: "pageSize", value: "25")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String:Any]],
                let paginationObj = response["paginationInfo"] as? [String:Any],
                let tickets = JSONDecoder().decodeArray(of: [UserTicket].self, from: data),
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj)
                else {
                    delegate.didFailSyncTickets(errorData: APIError.getDefaultError())
                    return
            }
            
            delegate.didSyncTicketsPage(tickets: tickets, pagination: pagination)
        }) { (error) in
            delegate.didFailSyncTickets(errorData: error)
        }
    }
}
