//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionTicket: NSObject, Decodable {
    public var id: Int = 0
    public var code: String = ""
    public var name: String = ""
    public var checked: String = ""
    public var lastUpdate: String = ""
    public var transferred: Bool = false
    public var ticket: String = ""
    public var type: String = ""
    public var ticketId: String = ""
    public var typeId: String = ""
    public var price: String = ""
    public var tax: String = ""
    public var percentTax: Int = 0
    public var sessions: [BasketSessions] = []

    enum CodingKeys: String, CodingKey {
        case id
        case code
        case name
        case checked
        case lastUpdate
        case transferred
        case ticket
        case ticketId
        case type
        case typeId
        case price
        case tax
        case percentTax
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.safeDecodeTo(Int.self, forKey: .id) ?? 0
        code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        checked = container.safeDecodeTo(Bool.self, forKey: .checked) ?? false
        lastUpdate = container.safeDecodeTo(Int.self, forKey: .lastUpdate) ?? 0
        transferred = container.safeDecodeTo(Bool.self, forKey: .transferred) ?? false
        ticket = try container.decodeIfPresent(String.self, forKey: .ticket) ?? ""
        ticketId = container.safeDecodeTo(Int.self, forKey: .ticketId) ?? 0
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        typeId = container.safeDecodeTo(Int.self, forKey: .typeId) ?? 0
        price = try container.decodeIfPresent(String.self, forKey: .price) ?? ""
        tax = try container.decodeIfPresent(String.self, forKey: .tax) ?? ""
        percentTax = container.safeDecodeTo(Int.self, forKey: .percentTax) ?? 0
        sessions = try container.decodeIfPresent([BasketSessions].self, forKey: .sessions) ?? []
    }
}
