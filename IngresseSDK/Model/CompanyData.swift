//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyData: NSObject, Decodable {
    @objc public var userId: Int = -1
    @objc public var token: String = ""
    @objc public var authToken: String = ""
    @objc public var company: Company?
    @objc public var application: CompanyApp?

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
        company = container.safeDecodeKey(.company, to: Company.self)
        application = container.safeDecodeKey(.application, to: CompanyApp.self)
    }
}
