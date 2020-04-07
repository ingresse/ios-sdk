//
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol RestClientInterface {
    func POST(request: URLRequest,
              parameters: [String: Any],
              customHeader: [String: Any]?,
              onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
              onError: @escaping ErrorHandler)

    func POSTData(request: URLRequest,
                  data: Data?,
                  customHeader: [String: Any]?,
                  JSONData: Bool,
                  onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                  onError: @escaping ErrorHandler)
    
    func GET(request: URLRequest,
             onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
             onError: @escaping ErrorHandler)

    func PUT(request: URLRequest,
             parameters: [String: Any],
             onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
             onError: @escaping ErrorHandler)

    func PUTData(request: URLRequest,
                 data: Data?,
                 JSONData: Bool,
                 onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                 onError: @escaping ErrorHandler)

    func DELETE(request: URLRequest,
                parameters: [String: Any],
                onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                onError: @escaping ErrorHandler)

    func DELETEData(request: URLRequest,
                    data: Data?,
                    JSONData: Bool,
                    onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                    onError: @escaping ErrorHandler)
}

extension RestClientInterface {
    func POSTData(request: URLRequest,
                  data: Data?,
                  customHeader: [String: Any]? = nil,
                  JSONData: Bool,
                  onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                  onError: @escaping ErrorHandler) {

        POSTData(request: request,
                 data: data,
                 customHeader: customHeader,
                 JSONData: JSONData,
                 onSuccess: onSuccess,
                 onError: onError)
    }

    func POST(request: URLRequest,
              parameters: [String: Any] = [:],
              customHeader: [String: Any]? = nil,
              onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
              onError: @escaping ErrorHandler) {

        POST(request: request,
             parameters: parameters,
             customHeader: customHeader,
             onSuccess: onSuccess,
             onError: onError)
    }
}
