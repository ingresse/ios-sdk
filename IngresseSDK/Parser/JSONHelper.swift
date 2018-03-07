//
//  JSONHelper.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 3/5/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension JSONDecoder {
    public func decodeDict<T:Codable>(of type: T.Type, from dict: [String:Any]) -> T? {
        return decodeData(of: type, data: dict.toData())
    }

    public func decodeArray<T:Codable>(of type: [T].Type, from dict: [[String:Any]]) -> [T]? {
        return decodeData(of: type, data: dict.toData())
    }

    private func decodeData<T:Codable>(of type: T.Type, data: Data?) -> T? {
        guard let obj = data else { return nil }
        do {
            return try self.decode(type, from: obj)
        } catch {
            print(error)
        }

        return nil
    }
}
