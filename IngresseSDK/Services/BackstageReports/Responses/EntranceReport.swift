//
//  EntranceReport.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 17/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public struct EntranceReportResponse: Decodable {
    public let checkedCount: Int?
    public let soldCount: Int?
    public let percentageValidations: Int?
    public let duration: String?
    public let startedAt: ReportDateTime?
    public let finishedAt: ReportDateTime?
    public let validationsByHour: [ValidationsByHour]?
    public let validationsByType: [ValidationsByType]?

    enum CodingKeys: String, CodingKey {
        case checkedCount = "checked_count"
        case soldCount = "sold_count"
        case percentageValidations = "percentage_validations"
        case duration
        case startedAt = "started_at"
        case finishedAt = "finished_at"
        case validationsByHour = "validations_per_hour"
        case validationsByType = "validations_per_type"
    }
    
    public struct ReportDateTime: Decodable {
        public let creationDate: String?
        public let timestamp: Int?
        
        enum CodingKeys: String, CodingKey {
            case creationDate = "creationdate"
            case timestamp
        }
    }
    
    public struct ValidationsByHour: Decodable {
        public let validationDate: String?
        public let validationHour: Int?
        public let validationTimestamp: Int?
        public let validated: Int?
        
        enum CodingKeys: String, CodingKey {
            case validationDate = "validation_date"
            case validationHour = "validation_hour"
            case validationTimestamp = "validation_timestamp"
            case validated
        }
    }
    
    public struct ValidationsByType: Decodable {
        public let id: String?
        public let validated: Int?
        public let totalSold: Int?
        public let percentageValidations: Int?
        public let name: String?
        public let tickets: [ValidationTicket]?
        
        enum CodingKeys: String, CodingKey {
            case id
            case validated
            case totalSold = "total_sold"
            case percentageValidations = "percentage_validations"
            case name
            case tickets
        }
        
        public init(from decoder: Decoder) throws {
            let container = try? decoder.container(keyedBy: CodingKeys.self)
            
            validated = try? container?.decodeIfPresent(Int.self, forKey: .validated)
            totalSold = try? container?.decodeIfPresent(Int.self, forKey: .totalSold)
            percentageValidations = try? container?.decodeIfPresent(Int.self, forKey: .percentageValidations)
            name = try? container?.decodeIfPresent(String.self, forKey: .name)
            tickets = try? container?.decodeIfPresent([ValidationTicket].self, forKey: .tickets)
            
            if let intId = try? container?.decodeIfPresent(Int.self, forKey: .id) {
                id = "\(intId)"
                return
            }
            
            id = try? container?.decodeIfPresent(String.self, forKey: .id)
            
        }
        
        public struct ValidationTicket: Decodable {
            public let id: Int?
            public let name: String?
            public let validated: Int?
            public let totalSold: Int?
            public let percentageValidations: Int?
            
            enum CodingKeys: String, CodingKey {
                case id
                case name
                case validated
                case totalSold = "total_sold"
                case percentageValidations = "percentage_validations"
            }
        }
    }
}
