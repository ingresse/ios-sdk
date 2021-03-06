//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class DateHelperTests: XCTestCase {
    
    func testStringToDate() {
        // Given
        let strDate = "01/01/2018 00:00"

        // When
        let date = strDate.toDate(format: .dateHourSpace)

        // Then
        let expected = DateComponents(calendar: Calendar.current, year: 2018, month: 01, day: 01, hour: 0, minute: 0, second: 0).date
        XCTAssertEqual(date, expected)
    }
    
    func testStringToDateError() {
        // Given
        let strDate = ""

        // When
        let date = strDate.toDate(format: .dateHourSpace)

        // Then
        XCTAssertEqual(date.timeIntervalSinceNow, 0, accuracy: 1)
    }

    func testGetWeekDay() {
        // Given
        let monday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 01).date
        let tuesday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 02).date
        let wednesday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 03).date
        let thrusday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 04).date
        let friday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 05).date
        let saturday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 06).date
        let sunday = DateComponents(
            calendar: Calendar.current,
            year: 2018,
            month: 01,
            day: 07).date

        let formatter = DateFormatter()
        formatter.dateFormat = DateFormat.timestamp.rawValue
        let posix = Locale(identifier: "en_US_POSIX")
        formatter.locale = posix

        let invalid = formatter.date(from: "2018-11-04'T'00:00:01-03:00")

        // Then
        XCTAssertEqual(monday?.weekDay(), "SEG")
        XCTAssertEqual(tuesday?.weekDay(), "TER")
        XCTAssertEqual(wednesday?.weekDay(), "QUA")
        XCTAssertEqual(thrusday?.weekDay(), "QUI")
        XCTAssertEqual(friday?.weekDay(), "SEX")
        XCTAssertEqual(saturday?.weekDay(), "SAB")
        XCTAssertEqual(sunday?.weekDay(), "DOM")
        XCTAssertEqual(invalid?.weekDay(), nil)
    }
}
