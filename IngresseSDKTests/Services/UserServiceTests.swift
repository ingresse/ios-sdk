//
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class UserServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: UserService!
    
    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(publicKey: "1234", privateKey: "2345", restClient: restClient)
        service = IngresseService(client: client).user
    }

    // MARK: - User Events
    func testGetUserEvents() {
        // Given
        let asyncExpectation = expectation(description: "userEvents")

        var response = [String:Any]()
        response["data"] = [["id": 1]]

        restClient.response = response
        restClient.shouldFail = false

        let delegate = UserEventsDownloaderDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(fromUsertoken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didDownloadEventsCalled)
            XCTAssertNotNil(delegate.resultData)
            XCTAssertEqual(delegate.resultData?[0]["id"] as? Int, 1)
        }
    }
    
    func testGetUserEventsWrongData() {
        // Given
        let asyncExpectation = expectation(description: "userEvents")

        var response = [String:Any]()
        response["data"] = nil

        restClient.response = response
        restClient.shouldFail = false

        let delegate = UserEventsDownloaderDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(fromUsertoken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailDownloadEventsCalled)
            XCTAssertNotNil(delegate.syncError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(delegate.syncError?.code, defaultError.code)
            XCTAssertEqual(delegate.syncError?.message, defaultError.message)
        }
    }
    
    func testGetUserEventsFail() {
        // Given
        let asyncExpectation = expectation(description: "userEvents")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        let delegate = UserEventsDownloaderDelegateSpy()
        delegate.asyncExpectation = asyncExpectation

        // When
        service.getEvents(fromUsertoken: "1234-token", page: 1, delegate: delegate)

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssert(delegate.didFailDownloadEventsCalled)
            XCTAssertNotNil(delegate.syncError)
            XCTAssertEqual(delegate.syncError?.code, 1)
            XCTAssertEqual(delegate.syncError?.message, "message")
            XCTAssertEqual(delegate.syncError?.category, "category")
        }
    }
    
    // MARK: - Verify Account
    func testVerifyAccount() {
        // Given
        let asyncExpectation = expectation(description: "verifyAccount")

        restClient.response = [:]
        restClient.shouldFail = false

        var success = false

        // When
        service.verifyAccount(userId: 1234, userToken: "1234-token", accountkitCode: "accountkitCode", onSuccess: {
            success = true
            asyncExpectation.fulfill()
        }) { (_) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
        }
    }
    
    func testVerifyAccountFail() {
        // Given
        let asyncExpectation = expectation(description: "verifyAccount")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.verifyAccount(userId: 1234, userToken: "1234-token", accountkitCode: "accountkitCode", onSuccess: {}) { (error) in
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

    // MARK: - Create Account
    func testCreateAccount() {
        // Given
        let asyncExpectation = expectation(description: "createAccount")

        var response = [String: Any]()
        response["status"] = 1
        response["data"] = [
            "userId": 1,
            "token": "1-token"
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: IngresseUser?

        // When
        service.createAccount(name: "name lastname", phone: "phone", email: "email", password: "password", newsletter: true, onSuccess: { (user) in
            success = true
            result = user
            asyncExpectation.fulfill()
        }) { (_) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.userId, 1)
        }
    }

    func testCreateAccountNoStatus() {
        // Given
        let asyncExpectation = expectation(description: "createAccount")

        var response = [String: Any]()
        response["data"] = [
            "userId": 1,
            "token": "1-token"
        ]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.createAccount(name: "name lastname", phone: "phone", email: "email", password: "password", newsletter: true, onSuccess: { (_) in }) { (error) in
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

    func testCreateAccountNoMessage() {
        // Given
        let asyncExpectation = expectation(description: "createAccount")

        var response = [String: Any]()
        response["status"] = 0

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.createAccount(name: "name lastname", phone: "phone", email: "email", password: "password", newsletter: true, onSuccess: { (_) in }) { (error) in
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

    func testCreateAccountError() {
        // Given
        let asyncExpectation = expectation(description: "createAccount")

        var response = [String: Any]()
        response["status"] = 0
        response["message"] = ["name", "email"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.createAccount(name: "name lastname", phone: "phone", email: "email", password: "password", newsletter: true, onSuccess: { (_) in }) { (error) in
            success = false
            apiError = error
            asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 0)
            XCTAssertEqual(apiError?.title, "Verifique suas informações")
            XCTAssertEqual(apiError?.message, "name\nemail")
        }
    }

    func testCreateAccountFail() {
        // Given
        let asyncExpectation = expectation(description: "createAccount")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.createAccount(name: "name lastname", phone: "phone", email: "email", password: "password", newsletter: true, onSuccess: { (_) in }) { (error) in
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

    // MARK: - Update basic infos
    func testUpdateBasicInfos() {
        // Given
        let asyncExpectation = expectation(description: "updateBasicInfos")

        var response = [String:Any]()
        response["status"] = 200
        response["data"] = ["ddi": "ddi",
                            "phone": "phone",
                            "id": "id",
                            "lastname": "lastname",
                            "verified": "verified",
                            "email": "email",
                            "cpf": "cpf",
                            "name": "name"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var result: UpdatedUser?

        // When
        service.updateBasicInfos(userId: "userId",
                                 userToken: "userToken",
                                 name: "name",
                                 lastname: "lastname",
                                 currentEmail: "currentEmail",
                                 newEmail: "newEmail",
                                 phone: "phone",
                                 cpf: "cpf", onSuccess: { (user) in
                                    success = true
                                    result = user
                                    asyncExpectation.fulfill()
        }) { (error) in }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertTrue(success)
            XCTAssertNotNil(result)
            XCTAssertEqual(result?.cpf, "cpf")
        }
    }

    func testUpdateBasicInfosFail() {
        let asyncExpectation = expectation(description: "updateBasicInfos")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.updateBasicInfos(userId: "userId",
                                 userToken: "userToken",
                                 name: "name",
                                 lastname: "lastname",
                                 currentEmail: "currentEmail",
                                 newEmail: "newEmail",
                                 phone: "phone",
                                 cpf: "cpf", onSuccess: {_ in }) { (error) in
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

    func testUpdateBasicInfosWithWrongResponse() {
        let asyncExpectation = expectation(description: "updateBasicInfos")

        var response = [String:Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.updateBasicInfos(userId: "userId",
                                 userToken: "userToken",
                                 name: "name",
                                 lastname: "lastname",
                                 currentEmail: "currentEmail",
                                 newEmail: "newEmail",
                                 phone: "phone",
                                 cpf: "cpf", onSuccess: {_ in }) { (error) in
                                        success = false
                                        apiError = error
                                        asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, APIError.getDefaultError().code)
            XCTAssertEqual(apiError?.message, APIError.getDefaultError().message)
            XCTAssertEqual(apiError?.category, APIError.getDefaultError().category)
        }
    }

    func testUpdateBasicInfosWithStatusZero() {
        let asyncExpectation = expectation(description: "updateBasicInfos")

        var response = [String:Any]()
        response["data"] = []
        response["status"] = 0
        response["message"] = ["message"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.updateBasicInfos(userId: "userId",
                                 userToken: "userToken",
                                 name: "name",
                                 lastname: "lastname",
                                 currentEmail: "currentEmail",
                                 newEmail: "newEmail",
                                 phone: "phone",
                                 cpf: "cpf", onSuccess: {_ in }) { (error) in
                                        success = false
                                        apiError = error
                                        asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 0)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "")
        }
    }

    func testUpdateBasicInfosWithStatusZeroWrongMessage() {
        let asyncExpectation = expectation(description: "updateBasicInfos")

        var response = [String:Any]()
        response["data"] = []
        response["status"] = 0
        response["message"] = [1]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.updateBasicInfos(userId: "userId",
                                 userToken: "userToken",
                                 name: "name",
                                 lastname: "lastname",
                                 currentEmail: "currentEmail",
                                 newEmail: "newEmail",
                                 phone: "phone",
                                 cpf: "cpf", onSuccess: {_ in }) { (error) in
                                        success = false
                                        apiError = error
                                        asyncExpectation.fulfill()
        }

        // Then
        waitForExpectations(timeout: 1) { (error:Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, APIError.getDefaultError().code)
            XCTAssertEqual(apiError?.message, APIError.getDefaultError().message)
            XCTAssertEqual(apiError?.category, APIError.getDefaultError().category)
        }
    }
}
