//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CheckinSession: NSObject, Decodable {
    public var session: Session?
    public var owner: User?
    public var lastStatus: CheckinStatus?

    enum CodingKeys: String, CodingKey {
        case session
        case owner
        case lastStatus
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        session = try container.decodeIfPresent(Session.self, forKey: .session)
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        lastStatus = try container.decodeIfPresent(CheckinStatus.self, forKey: .lastStatus)
    }

    public class Session: NSObject, Decodable {
        public var id: Int = 0
        public var dateTime: DateTime?

        enum CodingKeys: String, CodingKey {
            case id
            case dateTime
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
            dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
        }
    }

    public class DateTime: NSObject, Decodable {
        public var date: String = ""
        public var time: String = ""
        public var dateTime: String = ""

        enum CodingKeys: String, CodingKey {
            case date
            case time
            case dateTime
        }

        public required init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            date = try container.decodeIfPresent(String.self, forKey: .date) ?? ""
            time = try container.decodeIfPresent(String.self, forKey: .time) ?? ""
            dateTime = try container.decodeIfPresent(String.self, forKey: .dateTime) ?? ""
        }
    }
}
