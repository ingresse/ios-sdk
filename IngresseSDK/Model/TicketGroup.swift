//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import UIKit

public class TicketGroup: NSObject, Decodable {
    public var id: Int = -1
    public var name: String = ""
    public var desc: String = ""
    public var status: String = ""
    public var tickets: [Ticket] = [Ticket]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case status
        case tickets = "type"
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        tickets = container.decodeKey(.tickets, ofType: [Ticket].self)
    }
}
