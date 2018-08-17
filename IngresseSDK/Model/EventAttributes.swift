//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: NSObject, Codable {
    public var accepted_apps: [String] = []
    public var ticket_transfer_enabled: Bool = true
    public var ticket_transfer_required: Bool = false

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        accepted_apps = container.decodeKey(.accepted_apps, ofType: [String].self)
        ticket_transfer_enabled = container.decodeKey(.ticket_transfer_enabled, ofType: Bool.self)
        ticket_transfer_required = container.decodeKey(.ticket_transfer_required, ofType: Bool.self)
    }

    public static func fromJSON(_ json: [String: Any]) -> EventAttributes? {
        return JSONDecoder().decodeDict(of: EventAttributes.self, from: json)
    }
}
