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
    public func getAddressBy(zipCode: String, onSuccess: @escaping (_ response: Address) -> Void, onError: @escaping (_ error: APIError) -> Void){

        let url = URLBuilder(client: client)
            .setHost("https://cep.ingresse.com/")
            .setPath(zipCode)
            .build()

        client.restClient.GET(url: url, onSuccess: { (response) in
            let attributes = JSONDecoder().decodeDict(of: Address.self, from: response)!
            onSuccess(attributes)
        }) { (error) in
            onError(error)
        }
    }

    public func updateAddress(userId: String,
                              userToken: String,
                              zip: String,
                              street: String,
                              number: String,
                              complement: String,
                              district: String,
                              city: String,
                              state: String,
                              onSuccess: @escaping () -> Void, onError: @escaping (_ error: APIError) -> Void) {

        let url = URLBuilder(client: client)
            .setPath("user/\(userId)")
            .addParameter(key: "method", value: "update")
            .addParameter(key: "usertoken", value: userToken)
            .build()

        let params = ["zip" : zip,
                       "street" : street,
                       "number" : number,
                       "complement" : complement,
                       "district" : district,
                       "city" : city,
                       "state" : state]

        client.restClient.POST(url: url, parameters: params, onSuccess: { (response) in
            onSuccess()
        }) { (error) in
            onError(error)
        }
    }
}
