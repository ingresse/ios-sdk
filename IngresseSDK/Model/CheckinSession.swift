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
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
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
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            id = container.decodeKey(.id, ofType: Int.self)
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
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            date = container.decodeKey(.date, ofType: String.self)
            time = container.decodeKey(.time, ofType: String.self)
            dateTime = container.decodeKey(.dateTime, ofType: String.self)
        }
    }
}
