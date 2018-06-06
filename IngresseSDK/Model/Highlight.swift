//
//  Highlight.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 12/5/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class Highlight: Decodable, Equatable {
    public static func == (lhs: Highlight, rhs: Highlight) -> Bool {
        return lhs.banner == rhs.banner && lhs.target == rhs.target
    }

    public var banner: String = ""
    public var target: String = ""
}
