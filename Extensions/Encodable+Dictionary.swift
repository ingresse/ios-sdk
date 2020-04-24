//
//  Encodable+Dictionary.swift
//  IngresseSDK
//
//  Created by Fernando Ferreira on 23/04/20.
//

import Foundation

extension Encodable {

    var encoded: [String: Any]? {

        do {

            let data = try JSONEncoder().encode(self)
            let dictionaryAny = try JSONSerialization.jsonObject(with: data,
                                                                 options: .allowFragments)
            return dictionaryAny as? [String: Any]
        } catch {

            return nil
        }
    }
}
