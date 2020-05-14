//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public class LiveEventService: BaseService {
    public func getEventLiveURL(request: Request.Event.LiveEvent, onSuccess: @escaping (_ url: URLRequest) -> Void, onError: @escaping ErrorHandler) {

        var builder = URLBuilder(client: client)
            .setHost(.ingresseLive)
            .addEncodableParameter(request)

        if client.environment != .prod {
            let env = client.environment.rawValue.replacingOccurrences(of: "-", with: "")
            builder = builder.addParameter(key: "env", value: env)
        }

        guard let request = try? builder.build() else {
            return onError(APIError.getDefaultError())
        }

        onSuccess(request)
    }
}
