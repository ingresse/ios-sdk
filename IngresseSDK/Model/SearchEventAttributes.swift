//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct SearchEventAttributes: Codable, Equatable {
    public var liveEnabled: Bool = false
    public var liveId: String = ""
    public var saleEnabled: Bool = false

    enum CodingKeys: String, CodingKey {
        case liveEnabled
        case liveId
        case saleEnabled
    }

    enum AttrCodingKeys: String, CodingKey {
        case value
        case name
    }

    public init(from decoder: Decoder) throws {
        guard let attributes = try? decoder.container(keyedBy: CodingKeys.self) else { return }

        let liveEnabledContainer = try? attributes.nestedContainer(keyedBy: AttrCodingKeys.self, forKey: .liveEnabled)
        liveEnabled = try liveEnabledContainer?.decodeIfPresent(Bool.self, forKey: .value) ?? false

        let liveIdContainer = try? attributes.nestedContainer(keyedBy: AttrCodingKeys.self, forKey: .liveId)
        liveId = try liveIdContainer?.decodeIfPresent(String.self, forKey: .value) ?? ""

        let saleEnabledContainer = try? attributes.nestedContainer(keyedBy: AttrCodingKeys.self, forKey: .saleEnabled)
        saleEnabled = try saleEnabledContainer?.decodeIfPresent(Bool.self, forKey: .value) ?? false
    }
}
