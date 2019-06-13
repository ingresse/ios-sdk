//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Response {
    public struct Security {
        public struct PasswordStrength: Decodable {
            public var secure: Bool = false
            public var score: Score = Score()
            public var info: Info = Info()

            public struct Score: Decodable {
                public var max: Int = 0
                public var min: Int = 0
                public var minAcceptable: Int = 0
                public var password: Int = 0
            }

            public struct Info: Decodable {
                public var compromised: String?
                public var passwordStrength: String?
            }
        }
    }
}

extension Response.Security.PasswordStrength {
    enum CodingKeys: String, CodingKey {
        case secure
        case score
        case info
    }

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        secure = container.decodeKey(.secure, ofType: Bool.self)
        score = container.decodeKey(.score, ofType: Score.self)
        info = container.decodeKey(.info, ofType: Info.self)
    }
}
