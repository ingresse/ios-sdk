//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
import IngresseSDK

class PaymentServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: PaymentService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).payment
    }

    // MARK: - Do tickets reserve
    func testDoReserve() {
        // Given
        let asyncExpectation = expectation(description: "doReserve")

        var response  = [String:Any]()
        response["data"] = ["boleto": "boleto",
                            "message": "message",
                            "status": "status",
                            "tax": 0.0,
                            "total": 0.0,
                            "transactionId": "transactionId"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: PaymentResponse?

        // When
        service.doReserve(userToken: "userToken",
                          userId: "userId",
                          document: "dcument",
                          eventId: "eventId",
                          postback: "postback",
                          transactionId: "transactionId",
                          ingeprefsPayload: "ingeprefsPayload", onSuccess: { (response) in
                            success = true
                            result = response
                            asyncExpectation.fulfill()
        }) { (error) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.boleto, "boleto")
            XCTAssertEqual(result?.message, "message")
            XCTAssertEqual(result?.status, "status")
            XCTAssertEqual(result?.tax, 0.0)
            XCTAssertEqual(result?.total, 0.0)
            XCTAssertEqual(result?.transactionId, "transactionId")
        }
    }

    func testDoReserveWrongData() {
        // Given
        let asyncExpectation = expectation(description: "doReserve")
        let response = ["boleto": "boleto",
                        "message": "message",
                        "status": "status",
                        "tax": 0.0,
                        "total": 0.0,
                        "transactionId": "transactionId"] as [String:Any]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.doReserve(userToken: "userToken",
                          userId: "userId",
                          document: "dcument",
                          eventId: "eventId",
                          postback: "postback",
                          transactionId: "transactionId",
                          ingeprefsPayload: "ingeprefsPayload", onSuccess: { (response) in }) { (error) in
                            success = false
                            apiError = error
                            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testDoReserveFail() {
        let asyncExpectation = expectation(description: "doReserve")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.doReserve(userToken: "userToken",
                          userId: "userId",
                          document: "dcument",
                          eventId: "eventId",
                          postback: "postback",
                          transactionId: "transactionId",
                          ingeprefsPayload: "ingeprefsPayload", onSuccess: { (response) in }) { (error) in
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
