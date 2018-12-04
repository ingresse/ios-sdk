//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension JSONDecoder {
    public func decodeDict<T: Decodable>(of type: T.Type, from dict: [String: Any]) -> T? {
        return decodeData(of: type, data: dict.toData())
    }

    public func decodeArray<T: Decodable>(of type: [T].Type, from dict: [[String: Any]]) -> [T]? {
        return decodeData(of: type, data: dict.toData())
    }

    private func decodeData<T: Decodable>(of type: T.Type, data: Data?) -> T? {
        guard let obj = data,
            let decoded = try? self.decode(type, from: obj)
            else { return nil }

        return decoded
    }
}

extension KeyedDecodingContainer where K: CodingKey {
    /// Decode key considering string value with wrong type and null fields
    ///
    /// - Parameters:
    ///   - type: Use this for any type of decodable object
    ///   - key: key of the container
    /// - Returns: Value parsed to right type or nil
    public func safeDecodeKey<T>(_ key: K, to type: T.Type) -> T? where T: Decodable {
        if let firstTry = try? decodeIfPresent(type, forKey: key), firstTry != nil {
            return firstTry
        }

        guard let stringTry = try? decodeIfPresent(String.self, forKey: key),
            stringTry != nil,
            stringTry != "<null>" else {
            return nil
        }

        if T.self == Double.self {
            return Double(stringTry!) as? T
        }

        if T.self == Int.self {
            return Int(stringTry!) as? T
        }

        if T.self == Bool.self {
            return (stringTry == "1" || stringTry == "true") as? T
        }

        return nil
    }

    /// Decode value for key or get default value for type
    ///
    /// - Parameters:
    ///   - key: key to parse
    ///   - type: (Int, Double, String, Array or Bool)
    /// - Returns: Safe result for parsing
    func decodeKey<T: Decodable>(_ key: K, ofType type: T.Type) -> T {
        return safeDecodeKey(key, to: type) ?? defaultValueFor(type)
    }

    private func defaultValueFor<T: Decodable>(_ type: T.Type) -> T {
        if T.self == Int.self {
            return 0 as! T
        }

        if T.self == Bool.self {
            return false as! T
        }

        if T.self == String.self {
            return "" as! T
        }

        if String(describing: T.self).hasPrefix("Array") {
            return [] as! T
        }

        if String(describing: T.self).hasPrefix("Dict") {
            return [:] as! T
        }

        return 0.0 as! T
    }
}
