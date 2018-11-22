//
//  DictionaryDecodableTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

struct TestDecodable: DictionaryDecodable {
    static func fromDictionary(dictionary: [String : Any]?) -> TestDecodable? {
        if let json = dictionary {
            var obj = TestDecodable()
            obj.testString <<? json["testString"]
            return obj
        }
        return nil
    }
    
    var testString: String = "nothing"
}

class DictionaryDecodableTests: XCTestCase {

    func testSimple() {
        var testObj: TestDecodable?

        testObj <<? "hallo"
        XCTAssertNil(testObj)

        testObj <<? ["test": "hallo"]
        XCTAssertEqual(testObj?.testString, "nothing")

        testObj <<? ["testString": "hallo"]
        XCTAssertEqual(testObj?.testString, "hallo")

    }

}
