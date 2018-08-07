//
//  Copyright © 2016 Ingresse. All rights reserved.
//

import Foundation

public class ShopTicket: NSObject {
    // MARK: Ticket Properties
    var id:              Int    = 0
    var name:            String = ""
    var fullDescription: String = ""

    // MARK: Ticket Type Properties
    var guestTypeId: Int    = 0
    var status:      String = ""
    var typeName:    String = ""
    var price:       Double = 0
    var tax:         Double = 0
    var hidden:      Bool   = false

    // MARK: Cart Properties
    var quantity: Int = 0

    // MARK: Restrictions
    var maximum: Int = 99
    var minimum: Int = 1

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

    /**
     Set ticket Properties

     - Parameters:
     - id: Id of the ticket
     - name: Name of the ticket
     - description: Description of the Ticket
     - type: Dictionary with the ticket type data
     */
    func setProperties(_ id: NSInteger, name: String, description: String, type: TicketTypeData) {
        self.id              = id
        self.name            = name
        self.fullDescription = description

        // Set Ticket Type properties
        self.status      = type.status
        self.guestTypeId = type.id
        self.typeName    = type.name
        self.price       = type.price
        self.tax         = type.tax
        self.hidden      = type.hidden

        // Restrictions
        self.maximum     = type.max
        self.minimum     = type.min
    }

    /**
     Get price plus tax

     - Returns: Total ticket price
     */
    func totalPrice() -> Double {
        return self.price + self.tax;
    }

    /**
     Get price and text description
     *
     - Returns: Formated ticket price and tax
     */
    func getPriceAndTaxLabel() -> NSString {
        return String(format:NSLocalizedString("ticket price", comment: ""), self.getBrazilianCurrencyFormat(self.price), self.getBrazilianCurrencyFormat(self.tax)) as NSString;
    }

    /**
     Get price + tax label

     - Returns: Formatted ticket price + tax
     */
    func getTotalPriceLabel() -> NSString {
        return String(format:NSLocalizedString("price description", comment: ""), self.getBrazilianCurrencyFormat((self.totalPrice() * Double(self.quantity)))) as NSString;
    }

    /**
     Add one more ticket
     */
    func addOne() {
        if (self.quantity < self.minimum) {
            self.quantity = self.minimum;

            return;
        }

        if (self.quantity >= self.maximum) {
            self.quantity = self.maximum;

            return;
        }

        self.quantity += 1;
    }

    /**
     Remove ticket
     */
    func removeOne() {
        if (self.quantity <= self.minimum) {
            self.quantity = 0;
            return;
        }

        if (self.quantity > 0) {
            self.quantity -= 1;
        }
    }

    /**
     Reset quantity value to 0
     */
    func resetQuantity() {
        self.quantity = 0;
    }

    func getBrazilianCurrencyFormat(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.currencySymbol = ""
        return formatter.string(from: NSNumber(value: value))!

    }
}
