//
//  IngresseService.swift
//  IngresseSDK
//
//  Created by Rubens Gondek on 1/20/17.
//  Copyright © 2017 Gondek. All rights reserved.
//

public class IngresseService: NSObject {

    var client: IngresseClient!

    public init(client: IngresseClient) {
        self.client = client
    }

    // Lazy vars, only created when needed
    public lazy var auth: AuthService = {
        [unowned self] in
        return AuthService(self.client)
        }()

    public lazy var user: UserService = {
        [unowned self] in
        return UserService(self.client)
        }()

    public lazy var event: EventService = {
        [unowned self] in
        return EventService(self.client)
        }()

    public lazy var entrance: EntranceService = {
        [unowned self] in
        return EntranceService(self.client)
        }()

    public lazy var myTickets: MyTicketsService = {
        [unowned self] in
        return MyTicketsService(self.client)
        }()

    public lazy var transaction: TransactionService = {
        [unowned self] in
        return TransactionService(self.client)
        }()

    public lazy var transfers: TransfersService = {
        [unowned self] in
        return TransfersService(self.client)
        }()

    public lazy var search: SearchService = {
        [unowned self] in
        return SearchService(self.client)
        }()
}
