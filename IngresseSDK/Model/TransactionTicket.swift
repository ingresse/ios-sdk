//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionTicket: NSObject, Codable {
    public var id: Int = 0
    public var code: String = ""
    public var name: String = ""
    public var checked: Bool = false
    public var lastUpdate: Int = 0
    public var transferred: Bool = false
    public var ticket: String = ""
    public var type: String = ""
    public var ticketId: Int = 0
    public var typeId: Int = 0
    public var price: String = ""
    public var tax: String = ""
    public var percentTax: Int = 0
    public var sessions: [BasketSessions] = []

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        code = container.decodeKey(.code, ofType: String.self)
        name = container.decodeKey(.name, ofType: String.self)
        checked = container.decodeKey(.checked, ofType: Bool.self)
        lastUpdate = container.decodeKey(.lastUpdate, ofType: Int.self)
        transferred = container.decodeKey(.transferred, ofType: Bool.self)
        ticket = container.decodeKey(.ticket, ofType: String.self)
        ticketId = container.decodeKey(.ticketId, ofType: Int.self)
        type = container.decodeKey(.type, ofType: String.self)
        typeId = container.decodeKey(.typeId, ofType: Int.self)
        price = container.decodeKey(.price, ofType: String.self)
        tax = container.decodeKey(.tax, ofType: String.self)
        percentTax = container.decodeKey(.percentTax, ofType: Int.self)

        sessions = try container.decodeIfPresent([BasketSessions].self, forKey: .sessions) ?? []
    }
}
