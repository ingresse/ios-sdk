//
//  JSONConvertibleTests.swift
//  IngresseSDKTests
//
//  Created by Rubens Gondek on 2/16/18.
//  Copyright © 2018 Ingresse. All rights reserved.
//

import XCTest
@testable import IngresseSDK

class JSONConvertibleTests: XCTestCase {

    class TestClass: JSONConvertible {
        var fieldString = ""
        var fieldInt = 0
        var fieldBool = false
        var fieldFloat = 0.0
        var fieldArray = [ArrayObject]()
    }

    class ArrayObject: JSONConvertible {
        var field1 = ""
    }
    
    func testApplyJson() {
        var jsonDict = [String:Any]()
        jsonDict["fieldString"] = "test string"
        jsonDict["fieldInt"] = 10
        jsonDict["fieldBool"] = true
        jsonDict["fieldFloat"] = 99.99

        let obj = TestClass()
        obj.applyJSON(jsonDict)

        XCTAssertEqual(obj.fieldString, "test string")
        XCTAssertEqual(obj.fieldInt, 10)
        XCTAssertEqual(obj.fieldBool, true)
        XCTAssertEqual(obj.fieldFloat, 99.99)
    }

    func testApplyArray() {
        var array = [[String:Any]]()
        for i in 0...3 {
            let obj = ["field1":"object \(i)"]
            array.append(obj)
        }

        let obj = TestClass()
        obj.applyArray(key: "fieldArray", value: array, of: ArrayObject.self)

        for i in 0...3 {
            XCTAssertEqual(obj.fieldArray[i].field1, "object \(i)")
        }
    }

    func testApplyArrayData() {
        var array = [[String:Any]]()
        for i in 0...3 {
            let obj = ["field1":"object \(i)"]
            array.append(obj)
        }

        let data = ["data": array]

        let obj = TestClass()
        obj.applyArray(key: "fieldArray", value: data, of: ArrayObject.self)

        for i in 0...3 {
            XCTAssertEqual(obj.fieldArray[i].field1, "object \(i)")
        }
    }

    func testApplyArrayNilData() {
        let data = ["data": nil] as [String : Any?]

        let obj = TestClass()
        obj.applyArray(key: "fieldArray", value: data, of: ArrayObject.self)

        XCTAssertEqual(obj.fieldArray.count, 0)
    }

    func testApplyArrayWrongKey() {
        var array = [[String:Any]]()
        for i in 0...3 {
            let obj = ["field1":"object \(i)"]
            array.append(obj)
        }

        let obj = TestClass()
        obj.applyArray(key: "wrongKey", value: array, of: ArrayObject.self)

        for _ in 0...3 {
            XCTAssertEqual(obj.fieldArray.count, 0)
        }
    }

    func testApplyKeyString() {
        let obj = TestClass()
        obj.applyKey("fieldString", value: "test string")

        XCTAssertEqual(obj.fieldString, "test string")
    }

    func testApplyKeyInt() {
        let obj = TestClass()
        obj.applyKey("fieldInt", value: 150)

        XCTAssertEqual(obj.fieldInt, 150)
    }

    func testApplyKeyBool() {
        let obj = TestClass()
        obj.applyKey("fieldBool", value: true)

        XCTAssertEqual(obj.fieldBool, true)
    }

    func testApplyKeyFloat() {
        let obj = TestClass()
        obj.applyKey("fieldFloat", value: 25.25)

        XCTAssertEqual(obj.fieldFloat, 25.25)
    }

    func testApplyKeyWrongValue() {
        let obj = TestClass()
        obj.applyKey("fieldFloat", value: "test string")

        XCTAssertEqual(obj.fieldFloat, 0)
    }
}
