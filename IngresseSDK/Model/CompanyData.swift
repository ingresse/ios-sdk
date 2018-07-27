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
        guard let container = try? decoder.container(keyedBy: CodingKeys.self) else { return }
        userId = container.decodeKey(.userId, ofType: Int.self)
        token = container.decodeKey(.token, ofType: String.self)
        authToken = container.decodeKey(.authToken, ofType: String.self)
        company = try container.decodeIfPresent(Company.self, forKey: .company)
        application = try container.decodeIfPresent(CompanyApp.self, forKey: .application)
    }
}
