//
//  Copyright © 2017 Ingresse. All rights reserved.
//

public class TransferHistoryItem: NSObject, Decodable {
    public var id: Int = 0
    public var status: String = ""
    public var datetime: String = ""
    public var user: User?
}
