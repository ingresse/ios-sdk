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
}
