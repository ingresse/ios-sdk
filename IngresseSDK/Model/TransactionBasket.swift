//
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class TransactionBasket: NSObject, Decodable {
    @objc public var tickets: [TransactionTicket] = []
}
