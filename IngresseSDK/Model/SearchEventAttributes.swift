//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct SearchEventAttributes: Codable, Equatable {
    public var liveEnabled: Bool = false

    enum CodingKeys: String, CodingKey {
        case liveEnabled
    }

    enum AttrCodingKeys: String, CodingKey {
        case value
        case name
    }

    public init(from decoder: Decoder) throws {
        guard let attributes = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        let liveEnabledContainer = try? attributes.nestedContainer(keyedBy: AttrCodingKeys.self, forKey: .liveEnabled)
        liveEnabled = try liveEnabledContainer?.decodeIfPresent(Bool.self, forKey: .value) ?? false
    }
}
