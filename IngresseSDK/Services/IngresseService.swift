//
//  IngresseService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseService: NSObject {

    var client: IngresseClient!

    public var auth: AuthService!
    public var entrance: EntranceService!
    public var myTickets: MyTicketsService!
    public var transaction: TransactionService!
    public var user: UserService!

    public init(client: IngresseClient) {
        self.client = client
        self.auth = AuthService(client)
        self.entrance = EntranceService(client)
        self.myTickets = MyTicketsService(client)
        self.transaction = TransactionService(client)
        self.user = UserService(client)
    }
}
