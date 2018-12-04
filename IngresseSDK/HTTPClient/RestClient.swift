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
    
    /// REST POST Method using NSURLConnection
    ///
    /// - Parameters:
    ///   - url: request path
    ///   - parameters: post body parameters
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func POST(url: String, parameters: [String: Any], onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {

        let body = parameters.stringFromHttpParameters()

        if let data = body.data(using: .utf8) {
            POSTData(url: url,
                     data: data,
                     JSONData: false,
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
    public func POSTData(url: String, data: Data, JSONData: Bool, onSuccess: @escaping (_ responseData: [String: Any]) -> Void, onError: @escaping ErrorHandler) {
        var request = URLRequest(url: URL(string: url)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "POST"
        
        if let header = UserAgent.header {
            request.addValue(header, forHTTPHeaderField: "User-Agent")
        }
        
        if JSONData {
            request.addValue("application/json", forHTTPHeaderField: "content-type")
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
