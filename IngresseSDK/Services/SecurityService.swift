//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public class SecurityService: BaseService {

    /// Get password strength
    ///
    /// - Parameters:
    ///   - password: password to be verified
    ///   - onSuccess: success callback
    ///   - onError: error callback
    public func getPasswordStrength(password: String,
                                    onSuccess: @escaping (_ response: Response.Security.PasswordStrength) -> Void,
                                    onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("password")
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let param = ["password": password]
        client.restClient.POST(request: request,
                               parameters: param,
                               onSuccess: { response in

            guard let passwordStrength = JSONDecoder().decodeDict(of: Response.Security.PasswordStrength.self, from: response) else {
                onError(APIError.getDefaultError())
                return
            }

            onSuccess(passwordStrength)
        }, onError: onError)
    }
}
