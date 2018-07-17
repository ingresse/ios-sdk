//
//  TransactionBasket.swift
//  IngresseSDK
//
//  Created by Mobile Developer on 7/12/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

public class TransactionBasket: NSObject, Codable {
    public var tickets: [TransactionTicket] = []
}
