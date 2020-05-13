//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class LiveEventService: BaseService {
    public func getEventLiveURL(request: Request.Event.LiveEvent, onSuccess: @escaping (_ url: URLRequest) -> Void, onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setHost(.ingresseLive)
            .addEncodableParameter(request)

        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        onSuccess(request)
    }
}
