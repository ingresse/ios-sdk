//
//  Advertisement.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Advertisement: NSObject, Decodable {
    
    public var cover: CoverAd?
    public var background: BackgroundAd?

    enum CodingKeys: String, CodingKey {
        case cover
        case background
    }

    public required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        cover = try container.decodeIfPresent(CoverAd.self, forKey: .cover)
        background = try container.decodeIfPresent(BackgroundAd.self, forKey: .background)
    }
}
