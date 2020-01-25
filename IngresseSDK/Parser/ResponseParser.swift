//
//  Copyright © 2016 Gondek. All rights reserved.
//

public enum IngresseException: Error {
    case apiError(error: APIError)
    case genericError
    case requestError
    case httpError(status: Int)
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
    public static func build(_ response: URLResponse?, data: Data?, completion: (_ responseData: [String: Any]) -> Void) throws {
        guard data != nil && response != nil,
            let httpResponse = response as? HTTPURLResponse else {
            throw IngresseException.requestError
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw IngresseException.httpError(status: httpResponse.statusCode)
        }

        guard
            let objData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers),
            let obj = objData as? [String: Any] else {
                let httpResponse = response as? HTTPURLResponse
                if httpResponse?.statusCode == 200 || httpResponse?.statusCode == 204 {
                    completion(["status": true])
                    return
                }
                throw IngresseException.jsonParserError
        }

        // Address error
        if let objError = obj["error"] as? Bool,
            objError == true,
            let message = obj["message"] as? String {
            let error = APIError.Builder()
                .setCode(0)
                .setMessage(message)
                .build()

            throw IngresseException.apiError(error: error)
        }

        if let responseString = obj["responseData"] as? String {
            if !responseString.contains("[Ingresse Exception Error]") {
                throw IngresseException.genericError
            }

            // API Error
            guard
                let responseError = obj["responseError"] as? [String: Any],
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

        // Events API Error
        if let info = obj["info"] as? [String: Any],
            let code = obj["code"] as? Int,
            let message = obj["message"] as? String {

            let error = APIError.Builder()
                .setResponse(info)
                .setCode(code)
                .setError(message)
                .build()

            throw IngresseException.apiError(error: error)
        }

        // Simple object
        if let responseData = obj["responseData"] as? [String: Any] {
            completion(responseData)
            return
        }

        // List response
        if let responseArray = obj["responseData"] as? [[String: Any]] {
            completion(["data": responseArray])
            return
        }

        // Event API
        if let eventResponse = obj["data"] as? [String: Any] {
            completion(eventResponse)
            return
        }

        // Event API List
        if obj["data"] as? [[String: Any]] != nil {
            completion(obj)
            return
        }

        // Address
        if obj["zip"] as? String != nil {
            completion(obj)
            return
        }
        
        if let responseEspecial = obj as? [String: [String: String]] {
            completion(responseEspecial)
            return
        }
        
        throw IngresseException.jsonParserError
    }
}
