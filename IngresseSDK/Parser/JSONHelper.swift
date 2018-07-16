//
//  Copyright © 2018 Ingresse. All rights reserved.
//

extension JSONDecoder {
    public func decodeDict<T:Decodable>(of type: T.Type, from dict: [String:Any]) -> T? {
        return decodeData(of: type, data: dict.toData())
    }

    public func decodeArray<T:Decodable>(of type: [T].Type, from dict: [[String:Any]]) -> [T]? {
        return decodeData(of: type, data: dict.toData())
    }

    private func decodeData<T:Decodable>(of type: T.Type, data: Data?) -> T? {
        guard let obj = data else { return nil }
        do {
            return try self.decode(type, from: obj)
        } catch {
            print(error)
        }

        return nil
    }
}

extension KeyedDecodingContainer where K : CodingKey {
    public func safeDecodeTo<T>(_ type: T.Type, forKey key: K) -> T? where T: Decodable {
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
}