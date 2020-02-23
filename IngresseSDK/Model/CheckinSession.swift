//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CheckinSession: NSObject, Decodable {
    public var session: Session?
    public var owner: User?
    public var lastStatus: CheckinStatus?

    enum CodingKeys: String, CodingKey {
        case session
        case owner
        case lastStatus
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        session = try container.decodeIfPresent(Session.self, forKey: .session)
        owner = try container.decodeIfPresent(User.self, forKey: .owner)
        lastStatus = try container.decodeIfPresent(CheckinStatus.self, forKey: .lastStatus)
    }

    public class Session: NSObject, Decodable {
        public var id: Int = 0
        public var dateTime: DateTime?

        enum CodingKeys: String, CodingKey {
            case id
            case dateTime
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            id = container.decodeKey(.id, ofType: Int.self)
            dateTime = try container.decodeIfPresent(DateTime.self, forKey: .dateTime)
        }
    }

    public class DateTime: NSObject, Decodable {
        public var date: String = ""
        public var time: String = ""
        public var dateTime: String = ""

        enum CodingKeys: String, CodingKey {
            case date
            case time
            case dateTime
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            date = container.decodeKey(.date, ofType: String.self)
            time = container.decodeKey(.time, ofType: String.self)
            dateTime = container.decodeKey(.dateTime, ofType: String.self)
        }
    }
}


public class UserWalletTransaction: NSObject, Decodable {
    public var transactionId: String?
    public var createdAt: String?
    public var amount: Int?
    public var status: TransactionStatus?
    public var payment: Payment?
    public var tickets: [TransactionTicket]?
    public var event: Event?

    enum CodingKeys: String, CodingKey {
        case transactionId
        case createdAt
        case amount
        case status
        case payment
        case tickets
        case event
    }

    public required init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        amount = try container.decodeIfPresent(Int.self, forKey: .amount)
        status = try container.decodeIfPresent(TransactionStatus.self, forKey: .status)
        payment = try container.decodeIfPresent(Payment.self, forKey: .payment)
        tickets = try container.decodeIfPresent([TransactionTicket].self, forKey: .tickets)
        event = try container.decodeIfPresent(Event.self, forKey: .event)
    }
    
    public class TransactionTicket: NSObject, Decodable {
        public var id: Int?
        public var name: String?
        public var quantity: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case quantity
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            id = try container.decodeIfPresent(Int.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        }
    }
    
    public class TransactionStatus: NSObject, Decodable {
        public var current: CurrentStatus?

        enum CodingKeys: String, CodingKey {
            case current
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            current = try container.decodeIfPresent(CurrentStatus.self, forKey: .current)
        }
        
        public class CurrentStatus: NSObject, Decodable {
            public var name: String?
            public var comment: String?
            public var createdAt: String?

            enum CodingKeys: String, CodingKey {
                case name
                case comment
                case createdAt
            }

            public required init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                name = try container.decodeIfPresent(String.self, forKey: .name)
                comment = try container.decodeIfPresent(String.self, forKey: .comment)
                createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
            }
        }
    }
    
    public class Event: NSObject, Decodable {
        public var id: Any?
        public var title: String?

        enum CodingKeys: String, CodingKey {
            case id
            case title
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            title = try? container.decodeIfPresent(String.self, forKey: .title)
            do { id = try container.decodeIfPresent(Int.self, forKey: .id) }
            catch { id = try? container.decodeIfPresent(String.self, forKey: .id) }
        }
    }
    
    public class Payment: NSObject, Decodable {
        public var type: String?
        public var free: Bool?
        public var creditCard: CreditCard?
        public var declinedReason: DeclinedReason?

        enum CodingKeys: String, CodingKey {
            case type
            case free
            case creditCard
            case declinedReason
        }

        public required init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            type = try container.decodeIfPresent(String.self, forKey: .type)
            free = try container.decodeIfPresent(Bool.self, forKey: .free)
            creditCard = try container.decodeIfPresent(CreditCard.self, forKey: .creditCard)
            declinedReason = try container.decodeIfPresent(DeclinedReason.self, forKey: .declinedReason)
        }
        
        public class DeclinedReason: NSObject, Decodable {
            public var message: String?
            public var declinedBy: String?
            public var code: String?
            
            enum CodingKeys: String, CodingKey {
                case message
                case declinedBy
                case code
            }
            
            public required init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                message = try container.decodeIfPresent(String.self, forKey: .message)
                declinedBy = try container.decodeIfPresent(String.self, forKey: .declinedBy)
                code = try container.decodeIfPresent(String.self, forKey: .code)
            }
        }
        
        public class CreditCard: NSObject, Decodable {
            public var brand: String?
            public var expiration: String?
            public var holder: String?
            public var masked: String?
            public var cardFirst: String?
            public var cardLast: String?
            public var installments: Int?
            
            enum CodingKeys: String, CodingKey {
                case brand
                case expiration
                case holder
                case masked
                case cardFirst
                case cardLast
                case installments
            }
            
            public required init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                brand = try container.decodeIfPresent(String.self, forKey: .brand)
                expiration = try container.decodeIfPresent(String.self, forKey: .expiration)
                holder = try container.decodeIfPresent(String.self, forKey: .holder)
                masked = try container.decodeIfPresent(String.self, forKey: .masked)
                cardFirst = try container.decodeIfPresent(String.self, forKey: .cardFirst)
                cardLast = try container.decodeIfPresent(String.self, forKey: .cardLast)
                installments = try container.decodeIfPresent(Int.self, forKey: .installments)
            }
        }
    }
}
