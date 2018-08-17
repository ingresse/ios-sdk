//
//  Copyright © 2016 Gondek. All rights reserved.
//

public enum IngresseException: Error {
    case apiError(error: APIError)
    case genericError
    case requestError
    case jsonParserError
}

public class ResponseParser: NSObject {

    /// API Response parser
    ///
    /// - Parameters:
    ///   - response: Response of request
    ///   - data: byte representation of data
    ///   - completion: callback block
    /// - Throws: IngresseException
    public static func build(_ response: URLResponse?, data: Data?, completion: (_ responseData: [String: Any])->Void) throws {
        if data == nil || response == nil {
            throw IngresseException.requestError
        }

        guard
            let objData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers),
            let obj = objData as? [String:Any] else {
            throw IngresseException.jsonParserError
        }
        
        if let responseString = obj["responseData"] as? String {
            if !responseString.contains("[Ingresse Exception Error]") {
                throw IngresseException.genericError
            }

            // API Error
            guard
                let responseError = obj["responseError"] as? [String:Any],
                let code = responseError["code"] as? Int,
                let message = responseError["message"] as? String,
                let category = responseError["category"] as? String
                else { throw IngresseException.jsonParserError }

            let error = APIError.Builder()
                .setCode(code)
                .setCategory(category)
                .setError(message)
                .build()

            throw IngresseException.apiError(error: error)
        }

        // RSVP response
        if let status = obj["responseData"] as? Int {
            completion(["status": status])
            return
        }

        // Simple object
        if let responseData = obj["responseData"] as? [String:Any] {
            completion(responseData)
            return
        }

        // List response
        if let responseArray = obj["responseData"] as? [[String:Any]] {
            completion(["data": responseArray])
            return
        }

        // Event API
        if let eventResponse = obj["data"] as? [String:Any] {
            completion(eventResponse)
            return
        }

        // Event API List
        if let _ = obj["data"] as? [[String:Any]] {
            completion(obj)
            return
        }

        // Address
        if let zip = obj["zip"] as? String {
            completion(obj)
            return
        }

        throw IngresseException.jsonParserError
    }
}
