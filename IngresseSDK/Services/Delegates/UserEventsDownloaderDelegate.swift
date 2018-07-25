//
//  Copyright © 2018 Ingresse. All rights reserved.
//

@objc public protocol UserEventsDownloaderDelegate {
    func didDownloadEvents(_ userEvents: [[String: Any]])
    func didFailDownloadEvents(errorData: APIError)
}
