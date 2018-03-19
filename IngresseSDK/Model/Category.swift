//
//  Category.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/13/18.
//

public struct Category: Codable {

    public var id: Int = -1
    public var name: String = ""
    public var slug: String = ""
    public var isPublic: Bool = false

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case isPublic = "public"
    }
}
