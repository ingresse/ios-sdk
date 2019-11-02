//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EntranceService: BaseService {

    /// Get list of tickets for entrance (Guest List)
    ///
    /// - Requires: User token (logged user)
    ///
    /// - Parameters:
    ///   - eventId:    id of the event
    ///   - sessionId:  id of the event's session
    ///   - userToken:  user token required to make request
    ///   - page:       result page
    ///
    ///   - delegate:   callback listener
    public func getGuestListOfEvent(_ eventId: String, sessionId: String, from: Int = 0, userToken: String, page: Int, pageSize: Int = 1000, delegate: GuestListSyncDelegate) {
        var builder = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "page", value: page)
            .addParameter(key: "pageSize", value: pageSize)
            .addParameter(key: "sessionid", value: sessionId)
            .addParameter(key: "usertoken", value: userToken)
        
        if from != 0 {
            builder = builder.addParameter(key: "from", value: "\(from)")
        }
        
        let url = builder.build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let paginationData = response["paginationInfo"] as? [String: Any],
                let guests = JSONDecoder().decodeArray(of: [GuestTicket].self, from: data),
                let pagination = JSONDecoder().decodeDict(of: PaginationInfo.self, from: paginationData)
                else {
                    delegate.didFailSyncGuestList(errorData: APIError.getDefaultError())
                    return
            }
            
            delegate.didSyncGuestsPage(pagination, guests)
        }, onError: { (error) in
            delegate.didFailSyncGuestList(errorData: error)
        })
    }
    
    /// Make checkin of tickets
    ///
    /// - Requires: User token (logged user)
    ///
    /// - Parameters:
    ///   - ticketCodes: array with ticketCodes
    ///   - ticketStatus: array with ticketStatus
    ///   - ticketTimestamps: array with timestamps of last update
    ///   - eventId: id of the event
    ///   - userToken: token of logged user
    ///   - onSuccess: Success callback with array of [CheckinTickets]
    ///   - onError: Error callback with APIError
    public func checkinTickets(_ ticketCodes: [String], ticketStatus: [String], ticketTimestamps: [String], eventId: String, sessionId: String, userToken: String, onSuccess: @escaping (_ tickets: [CheckinTicket]) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "method", value: "updatestatus")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        var postParams = [String: [[String:String]]]()
        var tickets = [[String:String]]()
        for index in 0..<ticketCodes.count {
            var ticket = [String: String]()
            ticket["ticketCode"] = ticketCodes[index]
            ticket["ticketStatus"] = ticketStatus[index]
            ticket["ticketTimestamp"] = ticketTimestamps[index]
            ticket["sessionId"] = sessionId
            tickets.append(ticket)
        }
        postParams["tickets"] = tickets
        
        client.restClient.POST(url: url, parameters: postParams, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let tickets = JSONDecoder().decodeArray(of: [CheckinTicket].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(tickets)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    /// Get validation info of ticket
    ///
    /// - Requires: User token (logged user)
    ///
    /// - Parameters:
    ///   - code: ticket code
    ///   - eventId: event id
    ///   - userToken: token required
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getValidationInfoOfTicket(code: String, eventId: String, sessionId: String, userToken: String, onSuccess: @escaping (_ ticket: CheckinTicket) -> Void, onError: @escaping ErrorHandler) {
        
        let url = URLBuilder(client: client)
            .setPath("event/\(eventId)/guestlist")
            .addParameter(key: "method", value: "updatestatus")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        var postParams = [String: String]()
        postParams["tickets[0][ticketCode]"] = code
        postParams["tickets[0][ticketStatus]"] = "1"
        postParams["tickets[0][ticketTimestamp]"] = "\(Int(Date().timeIntervalSince1970)*1000)"
        postParams["tickets[0][sessionId]"] = sessionId
        
        client.restClient.POST(url: url, parameters: postParams, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let ticketData = data.first,
                let ticket = JSONDecoder().decodeDict(of: CheckinTicket.self, from: ticketData)
                else {
                    onError(APIError.getDefaultError())
                    return
            }
            
            onSuccess(ticket)
        }, onError: { (error) in
            onError(error)
        })
    }
    
    /// Get transfer history of ticket
    ///
    /// - Requires: User token (logged user)
    ///
    /// - Parameters:
    ///   - ticketId: id of ticket
    ///   - userToken: token of logged user
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getTransferHistory(ticketId: String, userToken: String, onSuccess: @escaping (_ history: [TransferHistoryItem]) -> Void, onError: @escaping ErrorHandler) {
        
        let url = URLBuilder(client: client)
            .setPath("ticket/\(ticketId)/transfer")
            .addParameter(key: "usertoken", value: userToken)
            .build()
        
        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let history = JSONDecoder().decodeArray(of: [TransferHistoryItem].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(history)
        }, onError: { (error) in
            onError(error)
        })
    }
}
