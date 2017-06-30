//
//  SessionSyncDelegate.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/19/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

@objc public protocol SessionSyncDelegate {
    func didSyncSessionsPage(_ sessions: [Session], finished: Bool)
    func didFailSyncSessions(errorData: [String:Any])
}
