//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
import IngresseSDK

class AddressServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: AddressService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client).address
    }

    // MARK: - Address by zip code
    func testGetAddressByZipCode() {
        // Given
        let asyncExpectation = expectation(description: "getAddressBy")

        let response  = ["street": "street",
                         "district": "district",
                         "state": "state",
                         "city": "city"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: Address?

        // When
        service.getAddressBy(zipCode: "zipCode", onSuccess: { (address) in
            success = true
            result = address
            asyncExpectation.fulfill()
        }) { (error) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.street, "street")
            XCTAssertEqual(result?.district, "district")
            XCTAssertEqual(result?.state, "state")
            XCTAssertEqual(result?.city, "city")
        }
    }

    func testGetAddressByZipCodeFail() {
        let asyncExpectation = expectation(description: "getAddressBy")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getAddressBy(zipCode: "zipcode", onSuccess: { (address) in }) { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Update address
    func testUpdateAddress() {
        // Given
        let asyncExpectation = expectation(description: "updateAddress")

        let response = [String:Any]()

        restClient.response = response
        restClient.shouldFail = false

        var success = false

        // When
        service.updateAddress(userId: "userId",
                              userToken: "userToken",
                              zip: "zip",
                              street: "street",
                              number: "number",
                              complement: "complement",
                              district: "district",
                              city: "city",
                              state: "state", onSuccess: {
                                success = true
                                asyncExpectation.fulfill()
        }) { (error) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
        }
    }

    func testUpdateAddressFail() {
        let asyncExpectation = expectation(description: "updateAddress")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.updateAddress(userId: "userId",
                              userToken: "userToken",
                              zip: "zip",
                              street: "street",
                              number: "number",
                              complement: "complement",
                              district: "district",
                              city: "city",
                              state: "state", onSuccess: {}) { (error) in
                                success = false
                                apiError = error
                                asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }
}
