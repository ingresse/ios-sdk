//
//  BackgroundAd.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/24/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import Foundation

public class BackgroundAd: NSObject, Decodable {
    public var image: String = ""

    enum CodingKeys: String, CodingKey {
        case image
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decodeIfPresent(String.self, forKey: .image) ?? ""
    }
}
