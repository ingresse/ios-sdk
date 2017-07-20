//
//  GuestListSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

@objc public protocol GuestListSyncDelegate {
    
    /// Callback method for listening to guest list download
    ///
    /// - Parameters:
    ///   - page: pagination info of current request
    ///   - guests: downloaded page of guests
    func didSyncGuestsPage(_ page: PaginationInfo, _ guests: [Guest])
    
    /// Callback for download errors
    ///
    /// - Parameter errorData: brings information about what went wrong
    func didFailSyncGuestList(errorData: APIError)
}
