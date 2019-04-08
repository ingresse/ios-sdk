//
//  Copyright © 2019 Ingresse. All rights reserved.
//

extension Request {
    public struct Event: Encodable {
        public struct RSVP {
            public var eventId: String = ""
            public var userToken: String = ""
            public var page: Int = 1
            public var pageSize: Int = 50
            public var delegate: RSVPSyncDelegate?
            
            public init() {}
        }

        public struct AddToRSVP {
            public var eventId: String = ""
            public var userToken: String = ""

            public init() {}
        }

        public struct RemoveToRSVP {
            public var eventId: String = ""
            public var userToken: String = ""

            public init() {}
        }
    }
}
