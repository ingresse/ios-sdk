//
//  EntranceReportRequest.swift
//  IngresseSDK
//
//  Created by Phillipi Unger Lino on 17/05/23.
//  Copyright © 2023 Ingresse. All rights reserved.
//

public struct EntranceReportRequest: Encodable {
    public let ticketGroupId: String?
    
    public init(ticketGroupId: String?) {
        self.ticketGroupId = ticketGroupId
    }
    
    enum CodingKeys: String, CodingKey {
        case ticketGroupId = "ticket_group_id"
    }
}
