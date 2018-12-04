//
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol RestClientInterface {
    func POST(url: String,
              parameters: [String: Any],
              onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
              onError: @escaping ErrorHandler)

    func POSTData(url: String,
                  data: Data,
                  JSONData: Bool,
                  onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                  onError: @escaping ErrorHandler)
    
    func GET(url: String,
             onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
             onError: @escaping ErrorHandler)
}
