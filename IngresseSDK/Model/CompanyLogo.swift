//
//  CompanyLogo.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 6/25/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CompanyLogo: NSObject, Decodable {
    public var small: String = ""
    public var medium: String = ""
    public var large: String = ""
    
    enum CodingKeys: String, CodingKey {
        case small
        case medium
        case large
    }
    
    public required init(from decoder: Decoder)  throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        medium = try container.decodeIfPresent(String.self, forKey: .medium) ?? ""
        large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
    }
}


