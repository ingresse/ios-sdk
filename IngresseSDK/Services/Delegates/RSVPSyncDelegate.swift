//
//  Copyright © 2019 Ingresse. All rights reserved.
//

public protocol RSVPSyncDelegate {
    func didSyncRSVPUsers(_ response: Response.Events.RSVP)
    func didFail(error: APIError)
}
