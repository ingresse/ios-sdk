//
//  Company.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 6/25/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class Company: NSObject, Decodable {
    public var id: Int = -1
    public var name: String = ""
    public var logo: CompanyLogo?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case logo
    }
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? -1
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        logo = try container.decodeIfPresent(CompanyLogo.self, forKey: .logo)
    }
}
