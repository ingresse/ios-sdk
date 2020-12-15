//
//  Copyright © 2020 Ingresse. All rights reserved.
//

public struct IngresseError: Decodable {
    let responseError: Self.ResponseError?
    
    struct ResponseError: Decodable {
        let status: Bool?
        let category: String?
        let code: Int?
        let message: String?
    }
}
