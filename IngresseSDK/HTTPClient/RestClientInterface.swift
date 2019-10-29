//
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol RestClientInterface {
    func POST(url: String,
              parameters: [String: Any],
              customHeader: [String: Any]?,
              onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
              onError: @escaping ErrorHandler)

    func POSTData(url: String,
                  data: Data?,
                  customHeader: [String: Any]?,
                  JSONData: Bool,
                  onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                  onError: @escaping ErrorHandler)
    
    func GET(url: String,
             onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
             onError: @escaping ErrorHandler)

    func PUT(url: String,
             parameters: [String: Any],
             onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
             onError: @escaping ErrorHandler)

    func PUTData(url: String,
                 data: Data?,
                 JSONData: Bool,
                 onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                 onError: @escaping ErrorHandler)

    func DELETE(url: String,
                parameters: [String: Any],
                onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                onError: @escaping ErrorHandler)

    func DELETEData(url: String,
                    data: Data?,
                    JSONData: Bool,
                    onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                    onError: @escaping ErrorHandler)
}

extension RestClientInterface {
    func POSTData(url: String,
                  data: Data?,
                  customHeader: [String: Any]? = nil,
                  JSONData: Bool,
                  onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                  onError: @escaping ErrorHandler) {
        POSTData(url: url, data: data, customHeader: customHeader, JSONData: JSONData, onSuccess: onSuccess, onError: onError)
    }

    func POST(url: String,
              parameters: [String: Any] = [:],
              customHeader: [String: Any]? = nil,
              onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
              onError: @escaping ErrorHandler) {
        POST(url: url, parameters: parameters, customHeader: customHeader, onSuccess: onSuccess, onError: onError)
    }
}
