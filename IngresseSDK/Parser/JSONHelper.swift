//
//  JSONHelper.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/5/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension JSONDecoder {
    public func decodeDict<T:Codable>(of type: T.Type, from dict: [String:Any]) -> T? {
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        let result = try? self.decode(type, from: data)

        return result
    }

    public func decodeArray<T:Codable>(of type: [T].Type, from dict: [[String:Any]]) -> [T]? {
        let data = NSKeyedArchiver.archivedData(withRootObject: dict)
        let result = try? self.decode(type, from: data)

        return result
    }
}
