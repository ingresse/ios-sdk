//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class NewTransfer: NSObject, Decodable {
    public var id: Int = -1
    public var status: String = ""
    public var saleTicketId: Int = 0
    public var user: User?
}
