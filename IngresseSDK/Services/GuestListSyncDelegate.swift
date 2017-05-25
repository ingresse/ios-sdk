//
//  GuestListSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 5/12/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import Foundation

@objc public protocol GuestListSyncDelegate {
    
    
    /// Callback method for listening to guest list download
    ///
    /// - Parameters:
    ///   - page: pagination info of current request
    ///   - guests: downloaded page of guests
    ///   - finished: returns true if it is the last page
    func didSyncGuestsPage(_ page: PaginationInfo, _ guests: [Guest], finished: Bool)
    
    
    /// Callback for download errors
    ///
    /// - Parameter errorData: brings information about what went wrong
    func didFailSyncGuestList(errorData: APIError)
}
