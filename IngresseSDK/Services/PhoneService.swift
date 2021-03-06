//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class PhoneService: BaseService {

    /// Get country's list with DDI
    ///
    /// - Parameters:
    ///     - onSuccess: success callback with DDI list
    ///     - onError: fail callback with APIError
    public func getDDIList(onSuccess: @escaping (_ response: [PhoneDDI]) -> Void,
                           onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("country")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in
            guard
                let data = response["data"] as? [[String: Any]],
                let ddiList = JSONDecoder().decodeArray(of: [PhoneDDI].self, from: data)
                else {
                    onError(APIError.getDefaultError())
                    return
            }

            onSuccess(ddiList)
        }, onError: onError)
    }
}
