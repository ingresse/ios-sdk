//
//  Copyright © 2017 Gondek. All rights reserved.
//

import Foundation

extension String {
    public func stringWithPercentEncoding() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension Dictionary {
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringWithPercentEncoding()!

            guard
                let stringValue = value as? String,
                let percentEscapedValue = stringValue.stringWithPercentEncoding()
                else {
                    let stringValue = String(describing: value).stringWithPercentEncoding()!
                    return "\(percentEscapedKey)=\(stringValue)"
            }

            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }

        return parameterArray.joined(separator: "&")
    }

    func toData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}

extension Array {
    func toData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
    }
}
