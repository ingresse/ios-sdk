//
//  Copyright © 2016 Ingresse. All rights reserved.
//

public class Transfer: NSObject, Codable {
    public var transferId: Int = 0
    public var userId: Int = 0
    public var status: String = ""
    public var email: String = ""
    public var name: String = ""
    public var type: String = ""
    public var picture: String = ""
    public var socialId: [SocialAccount] = []
    public var history: [StatusChange] = []

    public var created: String {
        return history.first(where: { $0.status == "pending" })?.creationDate ?? ""
    }

    public var accepted: String {
        return history.first(where: { $0.status == "accepted" })?.creationDate ?? ""
    }
    
    public var socialIdDict: [String: String] {
        return socialId.reduce(into: [String: String]()) { $0[$1.network] = $1.id }
    }

    public class StatusChange: NSObject, Codable {
        public var status: String = ""
        public var creationDate: String = ""
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        name = container.decodeKey(.name, ofType: String.self)
        type = container.decodeKey(.type, ofType: String.self)
        userId = container.decodeKey(.userId, ofType: Int.self)
        email = container.decodeKey(.email, ofType: String.self)
        status = container.decodeKey(.status, ofType: String.self)
        picture = container.decodeKey(.picture, ofType: String.self)
        transferId = container.decodeKey(.transferId, ofType: Int.self)
        history = container.decodeKey(.history, ofType: [StatusChange].self)
        socialId = container.decodeKey(.socialId, ofType: [SocialAccount].self)
    }
}
