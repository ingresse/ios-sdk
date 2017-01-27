//
//  IngresseService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

import UIKit

public class IngresseService {

    var client: IngresseClient!

    public var auth: AuthService!
    public var myTickets: MyTicketsService!

    public init(client: IngresseClient) {
        self.client = client
        self.auth = AuthService(client)
        self.myTickets = MyTicketsService(client)
    }
}
