//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventDate: NSObject, Codable {
    public var id: Int = 0
    public var date: String = ""
    public var time: String = ""
    public var status: String = ""
    public var dateTime: DateTime?

    public class DateTime: NSObject, Codable {
        public var date: String = ""
        public var time: String = ""
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: Int.self)
        status = container.decodeKey(.status, ofType: String.self)
        date = container.decodeKey(.date, ofType: String.self)
        time = container.decodeKey(.time, ofType: String.self)
        dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
    }
}
