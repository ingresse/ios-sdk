//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class SessionDate: NSObject, Codable {
    @objc public var date: String = ""
    @objc public var time: String = ""
    @objc public var dateTime: String = ""

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
