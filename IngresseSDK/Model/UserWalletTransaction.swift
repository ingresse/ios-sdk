//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct UserWalletTransaction: Decodable {
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

    public init(from decoder: Decoder) throws {
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        transactionId = try container.decodeIfPresent(String.self, forKey: .transactionId)
        createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
        amount = try container.decodeIfPresent(Int.self, forKey: .amount)
        status = try container.decodeIfPresent(TransactionStatus.self, forKey: .status)
        payment = try container.decodeIfPresent(Payment.self, forKey: .payment)
        tickets = try container.decodeIfPresent([TransactionTicket].self, forKey: .tickets)
        event = try container.decodeIfPresent(Event.self, forKey: .event)
    }
    
    public struct TransactionTicket: Decodable {
        public var id: Int?
        public var name: String?
        public var quantity: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case quantity
        }

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            id = try container.decodeIfPresent(Int.self, forKey: .id)
            name = try container.decodeIfPresent(String.self, forKey: .name)
            quantity = try container.decodeIfPresent(Int.self, forKey: .quantity)
        }
    }
    
    public struct TransactionStatus: Decodable {
        public var current: CurrentStatus?

        enum CodingKeys: String, CodingKey {
            case current
        }

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            current = try container.decodeIfPresent(CurrentStatus.self, forKey: .current)
        }
        
        public struct CurrentStatus: Decodable {
            public var name: String?
            public var comment: String?
            public var createdAt: String?

            enum CodingKeys: String, CodingKey {
                case name
                case comment
                case createdAt
            }

            public init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                name = try container.decodeIfPresent(String.self, forKey: .name)
                comment = try container.decodeIfPresent(String.self, forKey: .comment)
                createdAt = try container.decodeIfPresent(String.self, forKey: .createdAt)
            }
        }
    }
    
    public struct Event: Decodable {
        public var id: Any?
        public var title: String?

        enum CodingKeys: String, CodingKey {
            case id
            case title
        }

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            title = try? container.decodeIfPresent(String.self, forKey: .title)
            do {

                id = try container.decodeIfPresent(Int.self, forKey: .id)
            } catch {

                id = try? container.decodeIfPresent(String.self, forKey: .id)
            }
        }
    }
    
    public struct Payment: Decodable {
        public var type: String?
        public var free: Bool?
        public var creditCard: CreditCard?
        public var bankBillet: BankBillet?
        public var declinedReason: DeclinedReason?
        public var acquirer: String?

        enum CodingKeys: String, CodingKey {
            case type
            case free
            case creditCard
            case declinedReason
            case bankBillet
            case acquirer
        }
        
        enum AcquirerCodingKeys: String, CodingKey {
            case name
        }

        public init(from decoder: Decoder) throws {
            guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
            type = try container.decodeIfPresent(String.self, forKey: .type)
            free = try container.decodeIfPresent(Bool.self, forKey: .free)
            creditCard = try container.decodeIfPresent(CreditCard.self, forKey: .creditCard)
            bankBillet = try container.decodeIfPresent(BankBillet.self, forKey: .bankBillet)
            declinedReason = try container.decodeIfPresent(DeclinedReason.self, forKey: .declinedReason)
            
            guard
                let acquirerData = try? container.nestedContainer(keyedBy: AcquirerCodingKeys.self, forKey: .acquirer)
                else { return }

            acquirer = acquirerData.decodeKey(.name, ofType: String.self)
        }
        
        public struct DeclinedReason: Decodable {
            public var message: String?
            public var declinedBy: String?
            public var code: String?
            
            enum CodingKeys: String, CodingKey {
                case message
                case declinedBy
                case code
            }
            
            public init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                message = try container.decodeIfPresent(String.self, forKey: .message)
                declinedBy = try container.decodeIfPresent(String.self, forKey: .declinedBy)
                code = try container.decodeIfPresent(String.self, forKey: .code)
            }
        }
        
        public struct CreditCard: Decodable {
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
            
            public init(from decoder: Decoder) throws {
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
        
        public struct BankBillet: Decodable {
            public var url: String?
            public var provider: String?
            public var expiration: String?
            public var barCode: String?
            
            enum CodingKeys: String, CodingKey {
                case url
                case provider
                case expiration
                case barCode
            }
            
            public init(from decoder: Decoder) throws {
                guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
                url = try container.decodeIfPresent(String.self, forKey: .url)
                provider = try container.decodeIfPresent(String.self, forKey: .provider)
                expiration = try container.decodeIfPresent(String.self, forKey: .expiration)
                barCode = try container.decodeIfPresent(String.self, forKey: .barCode)
            }
        }
    }
}
