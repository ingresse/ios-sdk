//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class IngresseUserTests: XCTestCase {
    func testLogin() {
        // Given
        var json = [String: Any]()
        json["userId"] = 999
        json["token"] = "userToken"
        json["authToken"] = "authToken"

        // When
        let user = IngresseUser.login(loginData: json)

        // Then
        XCTAssertNotNil(IngresseUser.user)
        XCTAssertEqual(user.userId, 999)
        XCTAssertEqual(user.token, "userToken")
        XCTAssertEqual(user.authToken, "authToken")
    }
    
    func testLoginWrongData() {
        // Given
        let json = [String: Any]()

        // When
        let user = IngresseUser.login(loginData: json)

        // Then
        XCTAssertNotNil(IngresseUser.user)
        XCTAssertEqual(user.userId, 0)
        XCTAssertEqual(user.token, "")
    }

    func testLogout() {
        // Given
        var json = [String: Any]()
        json["userId"] = 999
        json["token"] = "userToken"
        let user = JSONDecoder().decodeDict(of: IngresseUser.self, from: json)
        IngresseUser.user = user

        // When
        IngresseUser.logout()

        // Then
        XCTAssertNil(IngresseUser.user)
    }
    
    func testFillData() {
        // Given
        var json = [String: Any]()
        json["userId"] = 999
        json["token"] = "userToken"
        json["authToken"] = "authToken"
        _ = IngresseUser.login(loginData: json)

        var data = [String: Any]()
        data["name"] = "name"
        data["lastname"] = "lastname"
        data["email"] = "email"
        data["state"] = "state"
        data["city"] = "city"
        data["district"] = "district"
        data["street"] = "street"
        data["zip"] = "zip"
        data["complement"] = "complement"
        data["phone"] = "phone"
        data["number"] = "number"
        data["fbUserId"] = "fbUserId"
        data["verified"] = true
        data["type"] = "type"

        // When
        IngresseUser.fillData(userData: data)

        // Then
        let user = IngresseUser.user
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.userId, 999)
        XCTAssertEqual(user?.token, "userToken")
        XCTAssertEqual(user?.authToken, "authToken")

        let userData = user?.data
        XCTAssertNotNil(userData)
        XCTAssertEqual(userData?.name, "name")
        XCTAssertEqual(userData?.lastname, "lastname")
        XCTAssertEqual(userData?.email, "email")
        XCTAssertEqual(userData?.state, "state")
        XCTAssertEqual(userData?.city, "city")
        XCTAssertEqual(userData?.district, "district")
        XCTAssertEqual(userData?.street, "street")
        XCTAssertEqual(userData?.zip, "zip")
        XCTAssertEqual(userData?.complement, "complement")
        XCTAssertEqual(userData?.phone, "phone")
        XCTAssertEqual(userData?.number, "number")
        XCTAssertEqual(userData?.fbUserId, "fbUserId")
        XCTAssertEqual(userData?.verified, true)
        XCTAssertEqual(userData?.type, "type")
    }
}
