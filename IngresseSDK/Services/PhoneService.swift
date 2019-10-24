//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class PhoneService: BaseService {

    /// Get country's list with DDI
    ///
    /// - Parameters:
    ///     - onSuccess: success callback with User array
    ///     - onError: fail callback with APIError
    public func getDDIList(onSuccess: @escaping (_ response: [PhoneDDI]) -> Void, onError: @escaping ErrorHandler) {
        let url = URLBuilder(client: client)
            .setPath("country")
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            guard
                let data = response["data"] as? [[String: Any]],
                let ddiList = JSONDecoder().decodeArray(of: [PhoneDDI].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(ddiList)
        }, onError: { (error) in
            onError(error)
        })
    }
}
