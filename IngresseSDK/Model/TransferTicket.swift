//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransferTicket: NSObject, Codable {
    public var id: Int = 0
    public var guestTypeId: Int = 0
    public var ticketTypeId: Int = 0
    public var name: String = ""
    public var type: String = ""
    public var desc: String = ""

    enum CodingKeys: String, CodingKey {
        case desc = "description"
        case id
        case guestTypeId
        case ticketTypeId
        case name
        case type
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        guestTypeId = container.decodeKey(.guestTypeId, ofType: Int.self)
        ticketTypeId = container.decodeKey(.ticketTypeId, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
    }
}
