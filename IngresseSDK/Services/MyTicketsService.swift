//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class MyTicketsService: BaseService {
    
    /// Get sessions user has tickets to
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - from: past or future events
    ///   - page: page of request
    ///   - pageSize: number of events per page
    ///   - delegate: callback interface
    public func getUserWallet(userId: String,
                              userToken: String,
                              from: String = "",
                              page: Int,
                              pageSize: Int = 50,
                              delegate: WalletSyncDelegate) {

        var builder = URLBuilder(client: client)
            .setPath("user/\(userId)/wallet")
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .addParameter(key: "pageSize", value: String(pageSize))

        if from == "future" {
            builder = builder.addParameter(key: "order", value: "ASC")
            builder = builder.addParameter(key: "from", value: "yesterday")
        }

        if from == "past" {
            builder = builder.addParameter(key: "order", value: "DESC")
            builder = builder.addParameter(key: "to", value: "yesterday")
        }

        guard let request = try? builder.build() else {

            return delegate.didFailSyncItems(errorData: APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let paginationObj = response["paginationInfo"] as? [String: Any],
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj),
                let items = JSONDecoder().decodeArray(of: [WalletItem].self, from: data)
                else {
                    delegate.didFailSyncItems(errorData: APIError.getDefaultError())
                    return
            }

            delegate.didSyncItemsPage(items, from: from, pagination: pagination)
        }, onError: { error in
            delegate.didFailSyncItems(errorData: error)
        })
    }

    /// Get all tickets user has
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - eventId: id of requested event
    ///   - page: page of request
    ///   - delegate: callback interface
    public func getUserTickets(userId: String,
                               eventId: String,
                               userToken: String,
                               page: Int,
                               delegate: TicketSyncDelegate) {

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)/tickets")
            .addParameter(key: "eventId", value: eventId)
            .addParameter(key: "usertoken", value: userToken)
            .addParameter(key: "page", value: String(page))
            .addParameter(key: "pageSize", value: "25")

        guard let request = try? builder.build() else {

            return delegate.didFailSyncTickets(errorData: APIError.getDefaultError())
        }
        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let paginationObj = response["paginationInfo"] as? [String: Any],
                let tickets = JSONDecoder().decodeArray(of: [UserTicket].self, from: data),
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj)
                else {
                    delegate.didFailSyncTickets(errorData: APIError.getDefaultError())
                    return
            }
            
            delegate.didSyncTicketsPage(eventId: eventId, tickets: tickets, pagination: pagination)
        }, onError: { error in
            delegate.didFailSyncTickets(errorData: error)
        })
    }

    /// Get number of tickets for a given event
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - eventId: id of requested event
    ///   - userToken: token of logged user
    public func getWalletTicketsOf(request: Request.Wallet.NumberOfTickets,
                                   onSuccess: @escaping (_ tickets: Int) -> Void,
                                   onError: @escaping (_ error: APIError) -> Void) {

        let builder = URLBuilder(client: client)
            .setPath("user/\(request.userId)/tickets")
            .addParameter(key: "eventId", value: request.eventId)
            .addParameter(key: "usertoken", value: request.userToken)
            .addParameter(key: "page", value: 1)
            .addParameter(key: "pageSize", value: "1")

        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }
        client.restClient.GET(request: request, onSuccess: { (response) in
            guard
                let paginationObj = response["paginationInfo"] as? [String: Any],
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationObj)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(pagination.totalResults)
        }, onError: onError)
    }
}
