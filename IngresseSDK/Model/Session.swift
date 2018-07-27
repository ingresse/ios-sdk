//
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Session: NSObject, Codable {
    public var id: Int = 0
    public var timestamp: String = ""
    public var date: Date {
        return timestamp.toDate()
    }

    enum CodingKeys: String, CodingKey {
        case id
        case timestamp = "datetime"
    }

    public class DateTime: NSObject, Codable {
        public var timestamp = ""

        public var date: String {
            return timestamp.toDate().toString(format: .dateHourAt)
        }
        public var dateTime: Date {
            return timestamp.toDate()
        }
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        id = container.decodeKey(.id, ofType: Int.self)
        timestamp = container.decodeKey(.timestamp, ofType: String.self)
    }
}
