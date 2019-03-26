//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Response {
    public struct Events {
        public struct SpecialEvent: Decodable {
            public var type: String? = ""
            public var btntext: String? = ""
            public var url: String? = ""
        }
    }
}
