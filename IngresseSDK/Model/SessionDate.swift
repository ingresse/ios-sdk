//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class SessionDate: NSObject, Codable {
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
