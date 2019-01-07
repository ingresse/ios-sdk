//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class TicketDate: NSObject, Codable {
    public var id: Int = -1
    public var date: String = ""
    public var time: String = ""
    public var datetime: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id
        case date
        case time
        case datetime
    }
    
    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        date = container.decodeKey(.date, ofType: String.self)
        time = container.decodeKey(.time, ofType: String.self)
        datetime = container.decodeKey(.datetime, ofType: String.self)
    }
}
