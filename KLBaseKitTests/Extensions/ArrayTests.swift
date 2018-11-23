//
//  ArrayTests.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class ArrayTests: XCTestCase {

    func testSafeRef() {
        let array = ["Hello", "World"]
        XCTAssertEqual(array.safeRef(0), "Hello")
        XCTAssertEqual(array.safeRef(1), "World")
        XCTAssertNil(array.safeRef(2))
    }
    
}
