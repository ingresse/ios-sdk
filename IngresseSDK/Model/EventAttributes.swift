//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class EventAttributes: NSObject, Codable {
    public var acceptedApps: [String] = []
    public var transferEnabled: Bool = true
    public var transferRequired: Bool = false
    public var creditCardTokenEnabled: Bool = false
    public var eventDisclaimer: Disclaimer?
    public var passportAtBottom: Bool = false
    public var passportCollapsed: Bool = false
    public var passportLabel: String = ""
    public var isExternal: Bool = false
    public var externalLink: String = ""

    enum CodingKeys: String, CodingKey {
        case acceptedApps = "accepted_apps"
        case transferEnabled = "ticket_transfer_enabled"
        case transferRequired = "ticket_transfer_required"
        case creditCardTokenEnabled = "creditcard_token"
        case passportAtBottom = "passport_at_bottom"
        case passportCollapsed = "passport_collapsed"
        case passportLabel = "passport_label"
        case eventDisclaimer = "event_disclaimer"
        case isExternal = "is_external"
        case externalLink = "external_link"
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        acceptedApps = container.decodeKey(.acceptedApps, ofType: [String].self)
        transferEnabled = container.decodeKey(.transferEnabled, ofType: Bool.self)
        transferRequired = container.decodeKey(.transferRequired, ofType: Bool.self)
        creditCardTokenEnabled = container.decodeKey(.creditCardTokenEnabled, ofType: Bool.self)
        passportAtBottom = container.decodeKey(.passportAtBottom, ofType: Bool.self)
        passportCollapsed = container.decodeKey(.passportCollapsed, ofType: Bool.self)
        passportLabel = container.decodeKey(.passportLabel, ofType: String.self)
        eventDisclaimer = container.safeDecodeKey(.eventDisclaimer, to: Disclaimer.self)
        isExternal = container.decodeKey(.isExternal, ofType: Bool.self)
        externalLink = container.decodeKey(.externalLink, ofType: String.self)
    }

    public static func fromJSON(_ json: [String: Any]) -> EventAttributes? {
        return JSONDecoder().decodeDict(of: EventAttributes.self, from: json)
    }
}
