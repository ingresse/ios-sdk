//
//  Advertisement.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 9/20/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Advertisement: NSObject, Codable {
    
    public var cover: CoverAd?
    public var background: BackgroundAd?

    public class Ad: NSObject, Codable {
        public var image: String = ""
    }

    public class CoverAd: Ad {
        public var url: String = ""
    }

    public class BackgroundAd: Ad {}
}
