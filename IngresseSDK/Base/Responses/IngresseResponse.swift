//
//  Copyright © 2020 Ingresse. All rights reserved.
//

import Foundation

public struct IngresseData<R: Decodable>: Decodable {
    public let responseData: R?
}
