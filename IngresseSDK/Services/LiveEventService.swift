//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class LiveEventService: BaseService {
    public func getEventLiveURL(userToken: String, liveEventId: String, onSuccess: @escaping (_ url: URLRequest) -> Void, onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setHost(.ingresseLive)
            .addParameter(key: "userToken", value: userToken)
            .addParameter(key: "liveId", value: liveEventId)

        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        onSuccess(request)
    }
}
