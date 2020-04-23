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

        public struct Search: Encodable {
            public let orderBy: String
            public let from: String
            public let to: String
            public let offset: Int
            public let size: Int
            public let title: String?
            public let description: String?

            public init(orderBy: String,
                        from: String,
                        to: String,
                        offset: Int,
                        size: Int,
                        title: String,
                        description: String) {

                self.orderBy = orderBy
                self.from = from
                self.to = to
                self.offset = offset
                self.size = size
                self.title = title.isEmpty ? nil : title
                self.description = description.isEmpty ? nil : description
            }
        }
    }
}
