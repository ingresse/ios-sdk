//
//  Copyright © 2017 Gondek. All rights reserved.
//

public class RestClient: NSObject, RestClientInterface {
    var session = URLSession(configuration: .default)

    /// REST GET Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func GET(request: URLRequest,
                    onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                    onError: @escaping ErrorHandler) {

        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                let errorData = APIError.Builder()
                    .setCode(0)
                    .setError(error!.localizedDescription)
                    .build()

                onError(errorData)
                return
            }
            
            do {
                try ResponseParser.build(response, data: data, completion: { (responseData: [String: Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch IngresseException.httpError(let status) {
                let errorData = APIError.Builder()
                    .setHttpStatus(status)
                    .build()

                onError(errorData)
            } catch {
                onError(APIError.getDefaultError())
            } 
        }.resume()
    }
    
    /// REST POST Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: post body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func POST(request: URLRequest,
                     parameters: [String: Any],
                     customHeader: [String: Any]?,
                     onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                     onError: @escaping ErrorHandler) {

        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            POSTData(request: request,
                     data: data,
                     customHeader: customHeader,
                     JSONData: true,
                     onSuccess: onSuccess,
                     onError: onError)
        }
    }

    /// REST POST Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - data: post data
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func POSTData(request: URLRequest,
                         data: Data?,
                         customHeader: [String: Any]?,
                         JSONData: Bool,
                         onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                         onError: @escaping ErrorHandler) {

        var request = request
        request.httpMethod = "POST"
        request.httpBody = data

        if let newHeaders = customHeader {
            newHeaders.keys.forEach { key in
                guard let stringValue = newHeaders[key] as? String else { return }
                request.addValue(stringValue, forHTTPHeaderField: key)
            }
        }

        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }
        
        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                let errorData = APIError.Builder()
                    .setCode(0)
                    .setError(error!.localizedDescription)
                    .build()

                onError(errorData)
                return
            }
            
            do {
                try ResponseParser.build(response, data: data, completion: { (responseData: [String: Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch IngresseException.httpError(let status) {
                let errorData = APIError.Builder()
                    .setHttpStatus(status)
                    .build()

                onError(errorData)
            } catch {
                onError(APIError.getDefaultError())
            }
        }.resume()
    }

    /// REST DELETE Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: delete body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func DELETE(request: URLRequest,
                       parameters: [String: Any],
                       onSuccess: @escaping (_ responseData: [String: Any]) -> Void,
                       onError: @escaping ErrorHandler) {
        
        let body = parameters.stringFromHttpParameters()
        if let data = body.data(using: .utf8) {
            DELETEData(request: request,
                       data: data,
                       JSONData: false,
                       onSuccess: onSuccess,
                       onError: onError)
        }
    }

    /// REST DELETE Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - data: delete data
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func DELETEData(request: URLRequest,
                           data: Data?,
                           JSONData: Bool,
                           onSuccess: @escaping ([String: Any]) -> Void,
                           onError: @escaping ErrorHandler) {

        var request = request
        request.httpMethod = "DELETE"
        request.httpBody = data

        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                let errorData = APIError.Builder()
                    .setCode(0)
                    .setError(error!.localizedDescription)
                    .build()

                onError(errorData)
                return
            }

            do {
                try ResponseParser.build(response, data: data, completion: { (responseData: [String: Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch {
                onError(APIError.getDefaultError())
            }
        }.resume()
    }

    /// REST PUT Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: delete body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func PUT(request: URLRequest,
                    parameters: [String: Any],
                    onSuccess: @escaping ([String: Any]) -> Void,
                    onError: @escaping ErrorHandler) {

        let body = parameters.stringFromHttpParameters()
        if let data = body.data(using: .utf8) {
            PUTData(request: request,
                    data: data,
                    JSONData: false,
                    onSuccess: onSuccess,
                    onError: onError)
        }
    }

    /// REST PUT Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: delete body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func PUTData(request: URLRequest,
                        data: Data?,
                        JSONData: Bool,
                        onSuccess: @escaping ([String: Any]) -> Void,
                        onError: @escaping ErrorHandler) {

        var request = request
        request.httpMethod = "PUT"
        request.httpBody = data

        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        session.dataTask(with: request) { (data, response, error) in
            guard error == nil else {
                let errorData = APIError.Builder()
                    .setCode(0)
                    .setError(error!.localizedDescription)
                    .build()

                onError(errorData)
                return
            }

            do {
                try ResponseParser.build(response, data: data, completion: { (responseData: [String: Any]) in
                    onSuccess(responseData)
                })
            } catch IngresseException.apiError(let apiError) {
                onError(apiError)
            } catch {
                onError(APIError.getDefaultError())
            }
        }.resume()
    }
}
