//
//  Copyright © 2022 Ingresse. All rights reserved.
//

public struct UserTransactionResponse: Decodable {
    public let event: Self.Event?
    public let sale: Self.Sale?
    public let items: Self.Items?
}
