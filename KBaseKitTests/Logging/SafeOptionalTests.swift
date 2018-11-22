//
//  SafeOptionalTests.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
import KBaseKit

class SafeOptionalTests: XCTestCase {

    func testStrings() {
        let nullString: String? = nil
        let nonNullString: String? = "Hallo"

        XCTAssertEqual(nullString.safeVal, "?")
        XCTAssertEqual(nonNullString.safeVal, "Hallo")

    }

    func testInts() {
        let nullInt: Int? = nil
        let nonNullInt: Int? = 1337

        XCTAssertEqual(nullInt.safeVal, 0)
        XCTAssertEqual(nonNullInt.safeVal, 1337)
    }

}
