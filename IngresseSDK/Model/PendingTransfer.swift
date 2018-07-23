//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class PendingTransfer: NSObject, Decodable {
    public var id: Int = 0
    public var event: Event?
    public var venue: Venue?
    public var session: Session?
    public var ticket: TransferTicket?
    public var receivedFrom: Transfer?
}
