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
    public func GET(url: String, onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)

        if let header = UserAgent.header {
            request.addValue(header, forHTTPHeaderField: "User-Agent")
        }
        
        if let auth = UserAgent.authorization {
            request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
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
    
    /// REST POST Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: post body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func POST(url: String, parameters: [String: Any], customHeader: [String: Any]?, onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {
        if let data = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
            POSTData(url: url,
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
    public func POSTData(url: String, data: Data?, customHeader: [String: Any]?, JSONData: Bool, onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "POST"
        
        if let header = UserAgent.header {
            request.addValue(header, forHTTPHeaderField: "User-Agent")
        }
        
        if let newHeaders = customHeader {
            newHeaders.keys.forEach { key in
                guard let stringValue = newHeaders[key] as? String else { return }
                request.addValue(stringValue, forHTTPHeaderField: key)
            }
        }

        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        if let auth = UserAgent.authorization {
            request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = data
        
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
    public func DELETE(url: String, parameters: [String: Any], onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {
        let body = parameters.stringFromHttpParameters()
        if let data = body.data(using: .utf8) {
            DELETEData(url: url,
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
    public func DELETEData(url: String, data: Data?, JSONData: Bool, onSuccess: @escaping ([String: Any]) -> Void, onError: @escaping ErrorHandler) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "DELETE"

        if let header = UserAgent.header {
            request.addValue(header, forHTTPHeaderField: "User-Agent")
        }

        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
        }

        if let auth = UserAgent.authorization {
            request.addValue("Bearer \(auth)", forHTTPHeaderField: "Authorization")
        }

        request.httpBody = data

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
