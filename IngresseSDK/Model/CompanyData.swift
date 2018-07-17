//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyData: NSObject, Decodable {
    public var userId: Int = -1
    public var token: String = ""
    public var authToken: String = ""
    public var company: Company?
    public var application: CompanyApp?

    enum CodingKeys: String, CodingKey {
        case userId
        case token
        case authToken
        case company
        case application
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        userId = try container.decodeIfPresent(Int.self, forKey: .userId) ?? -1
        token = try container.decodeIfPresent(String.self, forKey: .token) ?? ""
        authToken = try container.decodeIfPresent(String.self, forKey: .authToken) ?? ""
        company = try container.decodeIfPresent(Company.self, forKey: .company)
        application = try container.decodeIfPresent(CompanyApp.self, forKey: .application)
    }
}
