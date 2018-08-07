//
//  Copyright © 2017 Ingresse. All rights reserved.
//

import UIKit

class TicketTypeData: NSObject {

    var id: Int
    var beginSales: String
    var endSales: String
    var status: String
    var desc: String
    var name: String
    var hidden: Bool
    var price: Double
    var tax: Double
    var max: Int
    var min: Int
    var quantity: Int = 0
    var dates = [SessionDateData]()

    var totalPrice: Double {
        get {
            return price + tax
        }
    }

    // Empty init
    override init() {
        self.id = -1

        self.beginSales = ""
        self.endSales = ""
        self.status = ""
        self.desc = ""
        self.name = ""

        self.price = 0.0
        self.tax = 0.0

        self.max = 99
        self.min = 1

        self.hidden = false
    }

    func applyJSON(_ json: [String:Any]) {
        for key:String in json.keys {
            if key == "dates" {
                guard let sessions = json[key] as? [[String:Any]] else {
                    continue
                }

                self.dates = []

                for session in sessions {
                    let date = SessionDateData()
                    date.applyJSON(session)

                    self.dates.append(date)
                }

                continue
            }

            if key == "restrictions" {
                guard let restrictions = json[key] as? [String:Any] else {
                    continue
                }

                self.max = restrictions["maximum"] as? Int ?? 99
                self.min = restrictions["minimum"] as? Int ?? 1

                continue
            }

            let selectorKey = (key == "description" ? "desc" : key)
            if !self.responds(to: NSSelectorFromString(selectorKey)) {
                continue
            }

            let value = (json[key] is String ? (json[key] as? String)?.trim() : json[key])

            self.setValue(value, forKey: selectorKey)
        }
    }

    /**
     Add one more ticket
     */
    func addOne() {
        if (self.quantity < self.min) {
            self.quantity = self.min;

            return;
        }

        if (self.quantity >= self.max) {
            self.quantity = self.max;

            return;
        }

        self.quantity += 1;
    }

    /**
     Remove ticket
     */
    func removeOne() {
        if (self.quantity <= self.min) {
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

    /**
     Get price and text description
     *
     - Returns: Formated ticket price and tax
     */
    func getPriceAndTaxLabel() -> NSString {
        return String(format:NSLocalizedString("ticket price", comment: ""), self.price.getBrazilianCurrencyFormat(), self.tax.getBrazilianCurrencyFormat()) as NSString;
    }

    /**
     Get price + tax label

     - Returns: Formatted ticket price + tax
     */
    func getTotalPriceLabel() -> NSString {
        return String(format:NSLocalizedString("price description", comment: ""), (self.totalPrice * Double(self.quantity)).getBrazilianCurrencyFormat()) as NSString;
    }
}

extension Double {

    func getBrazilianCurrencyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyDecimalSeparator = ","
        formatter.currencyGroupingSeparator = "."
        formatter.currencySymbol = ""
        return formatter.string(from: NSNumber(value: self))!
    }
}
