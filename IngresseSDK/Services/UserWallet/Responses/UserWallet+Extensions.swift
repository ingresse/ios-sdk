//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public extension UserWallet {
    
    struct Live: Decodable {
        public let id: String?
        public let enabled: Bool?
    }
    
    struct Advertisement: Decodable {
        public let mobile: Self.Mobile?
        
        public struct Mobile: Decodable {
            public let background: Self.Background?
            public let cover: Self.Cover?
            
            public struct Background: Decodable {
                public let image: String?
            }
            
            public struct Cover: Decodable {
                public let image: String?
                public let url: String?
            }
        }
    }
    
    struct Cashless: Decodable {
        public let enabled: Bool?
    }
    
    struct Sessions: Decodable {
        public let data: [Self.SessionData]?
        
        public struct SessionData: Decodable {
            public let id: Int?
            public let datetime: String?
        }
    }
    
    struct CustomSessions: Decodable {
        public let name: String?
        public let slug: String?
        public let status: String?
    }
    
    struct Venue: Decodable {
        public let id: Int?
        public let city: String?
        public let complement: String?
        public let country: String?
        public let crossStreet: String?
        public let name: String?
        public let state: String?
        public let street: String?
        public let zipCode: String?
        public let hidden: Bool?
        public let latitude: Double?
        public let longitude: Double?
    }
}
