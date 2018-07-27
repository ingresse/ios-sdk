//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransactionEvent: NSObject, Codable {
    public var id: String = ""
    public var title: String = ""
    public var type: String = ""
    public var status: String = ""
    public var link: String = ""
    public var poster: String = ""
    public var venue: Venue?
    public var saleEnabled: Bool = false
    public var taxToCostumer: Int = 0

    public class Venue: NSObject, Codable {
        public var name: String = ""
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        id = container.decodeKey(.id, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        link = container.decodeKey(.link, ofType: String.self)
        title = container.decodeKey(.title, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        poster = container.decodeKey(.poster, ofType: String.self)
        taxToCostumer = container.decodeKey(.taxToCostumer, ofType: Int.self)
        saleEnabled = container.decodeKey(.saleEnabled, ofType: Bool.self)

        venue = try container.decodeIfPresent(Venue.self, forKey: .venue)
    }
}
