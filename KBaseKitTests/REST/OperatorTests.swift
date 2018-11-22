//
//  OperatorTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 18/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

struct OperatorObjectType: DictionaryDecodable {
    static func fromDictionary(dictionary: [String : Any]?) -> OperatorObjectType? {
        guard let json = dictionary else {
            return nil
        }
        var object = OperatorObjectType()
        object.string <<? json["string"]
        return object
    }
    
    var string: String = "nothing"
}

struct Test2ObjectType {
    var string: String = "nothing"
}

class OperatorTests: XCTestCase {
    let dict1 = ["string": "hallo1"] as NSDictionary
    let dict2 = ["string": "hallo2"] as NSDictionary
    let dict3 = ["string": "hallo3"] as NSDictionary

    func testOtherPart() {
        var testObject1 = Test2ObjectType()
        testObject1.string = "welt!"

        var testObjectA: Test2ObjectType?
        testObjectA <<? testObject1
        XCTAssertNotNil(testObjectA)
        XCTAssertEqual(testObjectA?.string, "welt!")

        var testObjectB: Test2ObjectType!
        testObjectB <<? testObject1
        XCTAssertNotNil(testObjectB)
        XCTAssertEqual(testObjectB.string, "welt!")

        var testObjectC = Test2ObjectType()
        testObjectC <<? testObject1
        XCTAssertNotNil(testObjectC)
        XCTAssertEqual(testObjectC.string, "welt!")
    }

    func testOtherPartNil() {
        var testObjectA: Test2ObjectType?
        testObjectA <<? nil
        XCTAssertNil(testObjectA)

        var testObjectB: Test2ObjectType!
        testObjectB <<? nil
        XCTAssertNil(testObjectB)

        var testObjectC = Test2ObjectType()
        testObjectC <<? nil
        XCTAssertNotNil(testObjectC)
        XCTAssertEqual(testObjectC.string, "nothing")
    }

    func testArrays() {
        var objects1 = [OperatorObjectType]()
        objects1 <<? [dict1, dict2, dict3]
        XCTAssertNotNil(objects1)
        XCTAssertEqual(objects1.count, 3)
        XCTAssertEqual(objects1[0].string, "hallo1")
        XCTAssertEqual(objects1[1].string, "hallo2")
        XCTAssertEqual(objects1[2].string, "hallo3")

        var objects2: [OperatorObjectType]!
        objects2 <<? [dict1, dict2, dict3]
        XCTAssertNotNil(objects2)
        XCTAssertEqual(objects2.count, 3)
        XCTAssertEqual(objects2[0].string, "hallo1")
        XCTAssertEqual(objects2[1].string, "hallo2")
        XCTAssertEqual(objects2[2].string, "hallo3")

        var objects3: [OperatorObjectType]?
        objects3 <<? [dict1, dict2, dict3]
        XCTAssertNotNil(objects3)
        XCTAssertEqual(objects3?.count, 3)
        XCTAssertEqual(objects3?[0].string, "hallo1")
        XCTAssertEqual(objects3?[1].string, "hallo2")
        XCTAssertEqual(objects3?[2].string, "hallo3")
    }

    func testOperators() {
        var object1 = OperatorObjectType()
        object1 <<? dict1
        XCTAssertNotNil(object1)
        XCTAssertEqual(object1.string, "hallo1")

        var object2: OperatorObjectType!
        object2 <<? dict2
        XCTAssertNotNil(object2)
        XCTAssertEqual(object2.string, "hallo2")

        var object3: OperatorObjectType?
        object3 <<? dict3
        XCTAssertNotNil(object3)
        XCTAssertEqual(object3?.string, "hallo3")
    }

}
