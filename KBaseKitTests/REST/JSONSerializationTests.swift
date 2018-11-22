//
//  JSONSerializationTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 18/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

struct TestObjectType: DictionaryDecodable {
    static func fromDictionary(dictionary: [String : Any]?) -> TestObjectType? {
        guard let json = dictionary else {
            return nil
        }
        var object = TestObjectType()
        object.string <<? json["string"]
        return object
    }
    
    var string: String = "nothing"
}

class JSONSerializationTests: XCTestCase {

    func testObject() {
        let testData = "{\"string\":\"hallo welt\"}".data(using: .utf8)
        let object = try! JSONSerialization.jsonObject(type: TestObjectType.self, data: testData)!
        XCTAssertEqual(object.string, "hallo welt")

        let testData1 = "{\"string\"::\"hallo welt\"}".data(using: .utf8)
        XCTAssertThrowsError(try JSONSerialization.jsonObject(type: TestObjectType.self, data: testData1))

        let testData2 = "[{\"string\":\"hallo welt\"}]".data(using: .utf8)
        XCTAssertThrowsError(try JSONSerialization.jsonObject(type: TestObjectType.self, data: testData2))
    }

    func testArray() {
        let testData = "[{\"string\":\"hallo welt\"}]".data(using: .utf8)
        let objects = try! JSONSerialization.jsonObjects(type: TestObjectType.self, data: testData)!
        XCTAssertEqual(objects.count, 1)
        XCTAssertEqual(objects.first?.string, "hallo welt")

        let testData1 = "[{\"string\"::\"hallo welt\"}]".data(using: .utf8)
        XCTAssertThrowsError(try JSONSerialization.jsonObjects(type: TestObjectType.self, data: testData1))

        let testData2 = "{\"string\":\"hallo welt\"}".data(using: .utf8)
        XCTAssertThrowsError(try JSONSerialization.jsonObjects(type: TestObjectType.self, data: testData2))
    }

}
