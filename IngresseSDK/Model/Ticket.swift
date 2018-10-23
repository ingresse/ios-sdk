//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Ticket: NSObject, Decodable {
    public var id: Int = -1
    public var name: String = ""
    public var desc: String = ""
    public var price: Double = 0.0
    public var tax: Double = 0.0
    public var beginSales: String = ""
    public var endSales: String = ""
    public var status: String = ""
    public var restrictions: [String: Int] = [String: Int]()
    public var hidden: Bool = false
    public var dates: [TicketDate] = [TicketDate]()
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case desc = "description"
        case price
        case tax
        case beginSales
        case endSales
        case status
        case restrictions
        case hidden
        case dates
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        name = container.decodeKey(.name, ofType: String.self)
        desc = container.decodeKey(.desc, ofType: String.self)
        price = container.decodeKey(.price, ofType: Double.self)
        tax = container.decodeKey(.tax, ofType: Double.self)
        beginSales = container.decodeKey(.beginSales, ofType: String.self)
        endSales = container.decodeKey(.endSales, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        restrictions = container.decodeKey(.restrictions, ofType: [String: Int].self)
        hidden = container.decodeKey(.hidden, ofType: Bool.self)
        dates = container.decodeKey(.dates, ofType: [TicketDate].self)
    }
}
