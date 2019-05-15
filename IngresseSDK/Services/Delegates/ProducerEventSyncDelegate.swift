//
//  Created by Phillipi Unger Lino on 28/02/2019.
//

public protocol ProducerEventSyncDelegate {
    func didSyncEvents(_ events: [NewEvent], offset: Int, total: Int)
    func didFail(error: APIError)
}
