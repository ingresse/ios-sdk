//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionSession: NSObject, Codable {
    @objc public var id: String = ""
    @objc public var dateTime: DateTime?
}

public class DateTime: NSObject, Codable {
    @objc public var date: String = ""
    @objc public var time: String = ""

    var tms: String?
    var dateTime: String = ""

    @objc public var timestamp: String {
        return tms ?? dateTime
    }

    enum CodingKeys: String, CodingKey {
        case tms = "timestamp"
        case date
        case time
        case dateTime
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        tms = try container.decodeIfPresent(String.self, forKey: .tms)
        date = container.decodeKey(.date, ofType: String.self)
        time = container.decodeKey(.time, ofType: String.self)
        dateTime = container.decodeKey(.dateTime, ofType: String.self)
    }
}
