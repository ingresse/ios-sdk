//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class GuestTicket: NSObject, Decodable {
    public var id: String = ""
    public var transactionId: String = ""
    public var code: String = ""
    public var userId: String = ""
    public var name: String = ""
    public var email: String = ""
    public var holderUserId: String = ""
    public var holderEmail: String = ""
    public var holderName: String = ""
    public var ticketId: String = ""
    public var ticket: String = ""
    public var type: String = ""
    public var guestTypeId: String = ""
    public var seatLocator: String = ""
    public var checked: String = ""
    public var lastUpdate: String = ""
    public var soldOnline: String = ""
    public var transferred: Bool = false
    
    public var isChecked: Bool {
        get {
            return checked == "1"
        }
    }

    enum CodingKeys: String, CodingKey {
        case id
        case transactionId
        case code
        case userId
        case name
        case email
        case holderUserId
        case holderEmail
        case holderName
        case ticketId
        case ticket
        case type
        case guestTypeId
        case seatLocator
        case checked
        case lastUpdate
        case soldOnline
        case transferred
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = try container.decodeIfPresent(String.self, forKey: .id) ?? ""
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId) ?? ""
        code = try container.decodeIfPresent(String.self, forKey: .code) ?? ""
        userId = try container.decodeIfPresent(String.self, forKey: .userId) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        holderUserId = try container.decodeIfPresent(String.self, forKey: .holderUserId) ?? ""
        holderEmail = try container.decodeIfPresent(String.self, forKey: .holderEmail) ?? ""
        holderName = try container.decodeIfPresent(String.self, forKey: .holderName) ?? ""
        ticketId = try container.decodeIfPresent(String.self, forKey: .ticketId) ?? ""
        ticket = try container.decodeIfPresent(String.self, forKey: .ticket) ?? ""
        type = try container.decodeIfPresent(String.self, forKey: .type) ?? ""
        guestTypeId = try container.decodeIfPresent(String.self, forKey: .guestTypeId) ?? ""
        seatLocator = try container.decodeIfPresent(String.self, forKey: .seatLocator) ?? ""
        checked = try container.decodeIfPresent(String.self, forKey: .checked) ?? ""
        lastUpdate = try container.decodeIfPresent(String.self, forKey: .lastUpdate) ?? ""
        soldOnline = try container.decodeIfPresent(String.self, forKey: .soldOnline) ?? ""
        transferred = container.safeDecodeTo(Bool.self, forKey: .transferred) ?? false
    }
}
