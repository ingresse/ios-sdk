//
//  CoverAd.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/24/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class CoverAd: NSObject, Decodable {
    public var image: String = ""
    public var url: String = ""

    enum CodingKeys: String, CodingKey {
        case image
        case url
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
        url = try container.decodeIfPresent(String.self, forKey: .url) ?? ""
    }
}
