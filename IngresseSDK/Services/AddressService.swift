//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class AddressService: BaseService {

    /// Get address infos by zipcode
    ///
    /// - Parameters:
    ///   - zipCode: address zipcode
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func getAddressBy(zipCode: String,
                             onSuccess: @escaping (_ response: Address) -> Void,
                             onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setHost(.cep)
            .setEnvironment(.prod)
            .setPath(zipCode)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        client.restClient.GET(request: request,
                              onSuccess: { response in

            let attributes = JSONDecoder().decodeDict(of: Address.self, from: response)!
            onSuccess(attributes)
        }, onError: onError)
    }

    /// Update address
    ///
    /// - Parameters:
    ///   - userId: id of logged user
    ///   - userToken: token of logged user
    ///   - zip: address zip
    ///   - street: address street
    ///   - number: address number
    ///   - complement: address complement
    ///   - district: address district
    ///   - city: address city
    ///   - state: address state
    ///   - onSuccess: success callback
    ///   - onError: fail callback
    public func updateAddress(userId: String, // swiftlint:disable:this function_parameter_count
                              userToken: String,
                              zip: String,
                              street: String,
                              number: String,
                              complement: String,
                              district: String,
                              city: String,
                              state: String,
                              onSuccess: @escaping () -> Void,
                              onError: @escaping ErrorHandler) {

        let builder = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
        guard let request = try? builder.build() else {

            return onError(APIError.getDefaultError())
        }

        let params = ["zip": zip,
                      "street": street,
                      "number": number,
                      "complement": complement,
                      "district": district,
                      "city": city,
                      "state": state]

        client.restClient.POST(request: request,
                               parameters: params,
                               onSuccess: { response in

            guard let status = response["status"] as? Int else {
                onError(APIError.getDefaultError())
                return
            }

            if status == 0 {
                guard let message = response["message"] as? [String] else {
                    onError(APIError.getDefaultError())
                    return
                }

                let error = APIError.Builder()
                    .setCode(0)
                    .setTitle("Verifique suas informações")
                    .setMessage(message.joined(separator: "\n"))
                    .setResponse(response)
                    .build()

                onError(error)
                return
            }

            onSuccess()
        }, onError: onError)
    }
}
