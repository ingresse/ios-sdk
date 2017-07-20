//
//  SpyGuestListSyncDelegate.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 6/8/17.
//  Copyright © 2017 Ingresse. All rights reserved.
//

import XCTest
import IngresseSDK

class SpyGuestListSyncDelegate: GuestListSyncDelegate {
    var calledDidSync: Bool = false
    var guestListSyncResult: [Guest]? = .none
    var calledDidFail: Bool = false
    var asyncExpectation: XCTestExpectation?
    
    func didSyncGuestsPage(_ page: PaginationInfo, _ guests: [Guest]) {
        guard let expectation = asyncExpectation else {
            XCTFail("Missing expectation!")
            return
        }
        
        calledDidSync = true
        guestListSyncResult = guests
        expectation.fulfill()
    }
    
    func didFailSyncGuestList(errorData: APIError) {
        guard let expectation = asyncExpectation else {
            XCTFail("Missing expectation!")
            return
        }
        
        calledDidFail = true
        expectation.fulfill()
    }
}
