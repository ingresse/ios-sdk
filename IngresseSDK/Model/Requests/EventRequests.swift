//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Request {
    public struct Event: Encodable {
        public struct Producer: Encodable {
            public var title: String = ""
            public var orderBy: String = ""
            public var size: Int = 0
            public var to: String = ""
            public var from: String = ""
            public var offset: Int = 0
            
            public init() {}
        }

        public struct AddToRSVP {
            public var eventId: String = ""
            public var userToken: String = ""

            public init() {}
        }

        public struct RemoveFromRSVP {
            public var eventId: String = ""
            public var userToken: String = ""

            public init() {}
        }
        
        public struct Search {
            public var filters: [String: String] = [:]
            public var orderBy: String = ""
            public var from: String = ""
            public var to: String = ""
            public var offset: Int = 0
            public var size: Int = 0
            
            public init() {}
        }
    }
}
