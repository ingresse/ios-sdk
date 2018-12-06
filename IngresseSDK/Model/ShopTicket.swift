//
//  Copyright © 2016 Ingresse. All rights reserved.
//

import Foundation

public class ShopTicket: NSObject {
    // MARK: Ticket Properties
    public var id: Int = 0
    public var name: String = ""
    public var fullDescription: String = ""

    // MARK: Ticket Type Properties
    public var guestTypeId: Int = 0
    public var status: String = ""
    public var typeName: String = ""
    public var price: Double = 0
    public var tax: Double = 0
    public var hidden: Bool = false

    // MARK: Cart Properties
    public var quantity: Int = 0

    // MARK: Restrictions
    public var maximum: Int = 99
    public var minimum: Int = 1

    public init(id: Int,
                name: String,
                fullDescription: String,
                guestTypeId: Int,
                status: String,
                typeName: String,
                price: Double,
                tax: Double,
                hidden: Bool,
                quantity: Int,
                maximum: Int,
                minimum: Int) {

        self.id = id
        self.name = name
        self.fullDescription = fullDescription
        self.guestTypeId = guestTypeId
        self.status = status
        self.typeName = typeName
        self.price = price
        self.tax = tax
        self.hidden = hidden
        self.quantity = quantity
        self.maximum = maximum
        self.minimum = minimum

    }
}
