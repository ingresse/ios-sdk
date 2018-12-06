//
//  Copyright © 2017 Gondek. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class AuthServiceTests: XCTestCase {
    var restClient: MockClient!
    var client: IngresseClient!
    var service: AuthService!

    override func setUp() {
        super.setUp()

        restClient = MockClient()
        client = IngresseClient(apiKey: "1234", userAgent: "", restClient: restClient)
        service = IngresseService(client: client).auth
    }

    override func tearDown() {
        super.tearDown()

        // Set user nil
        IngresseUser.user = nil
    }

    // MARK: - Login
    func testLogin() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true
        loginSuccessResponse["data"] = ["userId": 12345,
                                        "token": "12345-abcdefghijklmnopqrstuvxyz"]

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false

        // When
        service.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (user) in
            logged = true
            loginExpectation.fulfill()
        }, onError: { (error) in })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertTrue(logged)
        }
    }

    func testLoginNotLogged() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginFailResponse = [String: Any]()
        loginFailResponse["status"] = 0
        loginFailResponse["message"] = "Teste de falha"

        restClient.response = loginFailResponse
        restClient.shouldFail = false

        var logged = true
        var responseError: APIError?

        // When
        service.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (error) in
            responseError = error
            logged = false
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(logged, "\(responseError!.message)")
        }
    }

    func testLoginWrongData() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true
        loginSuccessResponse["data"] = []

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false
        var apiError: APIError?

        // When
        service.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (errorData) in
            logged = false
            apiError = errorData
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testLoginFail() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var logged = true
        var apiError: APIError?

        // When
        service.loginWithEmail("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (error) in
            apiError = error
            logged = false
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    func testLogout() {
        // Given
        var data = [String: Any]()
        data["userId"] = 1234
        data["token"] = "test token"

        _ = IngresseUser.login(loginData: data)

        XCTAssertNotNil(IngresseUser.user)

        // When
        IngresseUser.logout()

        // Then
        XCTAssertNil(IngresseUser.user)
    }

    func testFillDataUserNil() {
        // Given
        IngresseUser.logout()

        // When
        IngresseUser.fillData(userData: [String: Any]())

        // Then
        XCTAssertNil(IngresseUser.user)
    }

    // MARK: - Company Login
    func testCompanyLogin() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true

        var comp1 = [String: Any]()
        comp1["userId"] = 1
        comp1["token"] = "token-1"
        comp1["authToken"] = "authToken-1"
        comp1["company"] = ["id": 22]
        comp1["application"] = ["id": 33]

        var comp2 = [String: Any]()
        comp2["userId"] = 2
        comp2["token"] = "token-2"
        comp2["authToken"] = "authToken-2"
        comp2["company"] = ["id": 44]
        comp2["application"] = ["id": 55]

        loginSuccessResponse["data"] = [comp1, comp2]

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false
        var data: [CompanyData]?

        // When
        service.companyLogin("email@test.com", andPassword: "password", onSuccess: { (companies) in
            logged = true
            data = companies
            loginExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertTrue(logged)
            XCTAssertNotNil(data)
            XCTAssertEqual(data?.count, 2)
        }
    }

    func testCompanyLoginNotLogged() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = false
        loginSuccessResponse["message"] = "Error message"

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false
        var apiError: APIError?

        // When
        service.companyLogin("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (errorData) in
            logged = false
            apiError = errorData
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, -1)
            XCTAssertEqual(apiError?.error, "Error message")
        }
    }

    func testCompanyLoginWrongData() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true

        var comp = [String: Any]()
        comp["userId"] = 1
        comp["token"] = "token-1"
        comp["authToken"] = "authToken-1"
        comp["company"] = ["id": 22]
        comp["application"] = ["id": 33]

        loginSuccessResponse["data"] = comp

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false
        var apiError: APIError?

        // When
        service.companyLogin("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (errorData) in
            logged = false
            apiError = errorData
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testCompanyLoginFail() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var logged = false
        var apiError: APIError?

        // When
        service.companyLogin("email@test.com", andPassword: "password", onSuccess: { (_) in }, onError: { (errorData) in
            logged = false
            apiError = errorData
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Facebook Login
    func testFacebookLogin() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true
        loginSuccessResponse["data"] = ["userId": 12345,
                                        "token": "12345-abcdefghijklmnopqrstuvxyz"]

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false

        // When
        service.loginWithFacebook(email: "email@test.com", fbToken: "facebookToken", fbUserId: "1234", onSuccess: { (_) in
            logged = true
            loginExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertTrue(logged)
        }
    }

    func testFacebookLoginNotLogged() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginFailResponse = [String: Any]()
        loginFailResponse["status"] = 0
        loginFailResponse["message"] = "Error message"

        restClient.response = loginFailResponse
        restClient.shouldFail = false

        var logged = true
        var apiError: APIError?

        // When
        service.loginWithFacebook(email: "email@test.com", fbToken: "facebookToken", fbUserId: "1234", onSuccess: { (_) in }, onError: { (error) in
            apiError = error
            logged = false
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, -1)
            XCTAssertEqual(apiError?.error, "Error message")
        }
    }

    func testFacebookLoginWrongData() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        var loginSuccessResponse = [String: Any]()
        loginSuccessResponse["status"] = true
        loginSuccessResponse["data"] = []

        restClient.response = loginSuccessResponse
        restClient.shouldFail = false

        var logged = false
        var apiError: APIError?

        // When
        service.loginWithFacebook(email: "email@test.com", fbToken: "facebookToken", fbUserId: "1234", onSuccess: { (_) in }, onError: { (error) in
            apiError = error
            logged = false
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            let defaultError = APIError.getDefaultError()
            XCTAssertEqual(apiError?.code, defaultError.code)
            XCTAssertEqual(apiError?.message, defaultError.message)
        }
    }

    func testFacebookLoginFail() {
        // Given
        let loginExpectation = expectation(description: "loginCallback")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var logged = true
        var apiError: APIError?

        // When
        service.loginWithFacebook(email: "email@test.com", fbToken: "facebookToken", fbUserId: "1234", onSuccess: { (_) in }, onError: { (error) in
            apiError = error
            logged = false
            loginExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(logged)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - User Data
    func testGetUserDataFail() {
        // Given
        let userDataExpectation = expectation(description: "userData")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.getUserData(userId: "1234", userToken: "1234-token", onSuccess: { (_) in }, onError: { (errorData) in
            success = false
            apiError = errorData
            userDataExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 15) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Recover Password
    func testRecoverPassword() {
        // Given
        let recoverExpectation = expectation(description: "recoverPassword")

        restClient.response = [:]
        restClient.shouldFail = false

        var success = false

        // When
        service.recoverPassword(email: "email@test.com", onSuccess: {
            success = true
            recoverExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertTrue(success)
        }
    }

    func testRecoverPasswordFail() {
        // Given
        let recoverExpectation = expectation(description: "recoverPassword")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.recoverPassword(email: "email@test.com", onSuccess: {}, onError: { (error) in
            success = false
            apiError = error
            recoverExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Validate Hash
    func testValidateHash() {
        // Given
        let hashExpectation = expectation(description: "validateHash")

        restClient.response = [:]
        restClient.shouldFail = false

        var success = false

        // When
        service.validateHash("#hash", email: "email@test.com", onSuccess: {
            success = true
            hashExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertTrue(success)
        }
    }

    func testValidateHashFail() {
        // Given
        let hashExpectation = expectation(description: "validateHash")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.validateHash("#hash", email: "email@test.com", onSuccess: {}, onError: { (error) in
            success = false
            apiError = error
            hashExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Update Password
    func testUpdatePassword() {
        // Given
        let updatePasswordExpectation = expectation(description: "updatePassword")

        restClient.response = [:]
        restClient.shouldFail = false

        var success = false

        // When
        service.updatePassword(email: "email@test.com", password: "password", token: "#hash", onSuccess: {
            success = true
            updatePasswordExpectation.fulfill()
        }, onError: { (_) in })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertTrue(success)
        }
    }

    func testUpdatePasswordFail() {
        // Given
        let updatePasswordExpectation = expectation(description: "updatePassword")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.updatePassword(email: "email@test.com", password: "password", token: "#hash", onSuccess: {}, onError: { (error) in
            success = false
            apiError = error
            updatePasswordExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 5) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    // MARK: - Change Profile Password
    func testChangeProfilePassword() {
        // Given
        let asyncExpectation = expectation(description: "changeProfilePassword")

        var response = [String: Any]()
        response["status"] = 200
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false

        // When
        service.changeProfilePassword(currentPassword: "currentPass",
                                      newPassword: "newPass",
                                      token: "token",
                                      userId: "userId", onSuccess: {
                                        success = true
                                        asyncExpectation.fulfill()
        }, onError: { (error) in })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertTrue(success)
        }
    }

    func testChangeProfilePasswordFail() {
        let asyncExpectation = expectation(description: "changeProfilePassword")

        let error = APIError()
        error.code = 1
        error.message = "message"
        error.category = "category"

        restClient.error = error
        restClient.shouldFail = true

        var success = false
        var apiError: APIError?

        // When
        service.changeProfilePassword(currentPassword: "currentPass",
                                      newPassword: "newPass",
                                      token: "token",
                                      userId: "userId", onSuccess: {}, onError: { (error) in
                                        success = false
                                        apiError = error
                                        asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 1)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "category")
        }
    }

    func testChangeProfilePasswordWithWrongResponse() {
        let asyncExpectation = expectation(description: "changeProfilePassword")

        var response = [String: Any]()
        response["data"] = []

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.changeProfilePassword(currentPassword: "currentPass",
                                      newPassword: "newPass",
                                      token: "token",
                                      userId: "userId", onSuccess: {}, onError: { (error) in
                                success = false
                                apiError = error
                                asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, APIError.getDefaultError().code)
            XCTAssertEqual(apiError?.message, APIError.getDefaultError().message)
            XCTAssertEqual(apiError?.category, APIError.getDefaultError().category)
        }
    }

    func testChangeProfilePasswordWithStatusZero() {
        let asyncExpectation = expectation(description: "changeProfilePassword")

        var response = [String: Any]()
        response["data"] = []
        response["status"] = 0
        response["message"] = ["message"]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.changeProfilePassword(currentPassword: "currentPass",
                                      newPassword: "newPass",
                                      token: "token",
                                      userId: "userId", onSuccess: {}, onError: { (error) in
                                success = false
                                apiError = error
                                asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, 0)
            XCTAssertEqual(apiError?.message, "message")
            XCTAssertEqual(apiError?.category, "")
        }
    }

    func testChangeProfilePasswordWithStatusZeroWrongMessage() {
        let asyncExpectation = expectation(description: "changeProfilePassword")

        var response = [String: Any]()
        response["data"] = []
        response["status"] = 0
        response["message"] = [1]

        restClient.response = response
        restClient.shouldFail = false

        var success = false
        var apiError: APIError?

        // When
        service.changeProfilePassword(currentPassword: "currentPass",
                                      newPassword: "newPass",
                                      token: "token",
                                      userId: "userId", onSuccess: {}, onError: { (error) in
                                success = false
                                apiError = error
                                asyncExpectation.fulfill()
        })

        // Then
        waitForExpectations(timeout: 1) { (error: Error?) in
            XCTAssertFalse(success)
            XCTAssertNotNil(apiError)
            XCTAssertEqual(apiError?.code, APIError.getDefaultError().code)
            XCTAssertEqual(apiError?.message, APIError.getDefaultError().message)
            XCTAssertEqual(apiError?.category, APIError.getDefaultError().category)
        }
    }
}
