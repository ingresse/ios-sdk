//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: NSObject, Codable {
    public var acceptedApps: [String] = []
    public var transferEnabled: Bool = true
    public var transferRequired: Bool = false

    enum CodingKeys: String, CodingKey {
        case acceptedApps = "accepted_apps"
        case transferEnabled = "ticket_transfer_enabled"
        case transferRequired = "ticket_transfer_required"
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        acceptedApps = container.decodeKey(.acceptedApps, ofType: [String].self)
        transferEnabled = container.decodeKey(.transferEnabled, ofType: Bool.self)
        transferRequired = container.decodeKey(.transferRequired, ofType: Bool.self)
    }

    public static func fromJSON(_ json: [String: Any]) -> EventAttributes? {
        return JSONDecoder().decodeDict(of: EventAttributes.self, from: json)
    }
}
