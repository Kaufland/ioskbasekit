//
//  OptionalsTests.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class OptionalsTests: XCTestCase {
    
    func testStringOptional() {
        let test1: String? = "Hello"
        let test2: String? = nil
        
        XCTAssertEqual(test1.safeVal, "Hello")
        XCTAssertEqual(test2.safeVal, "?")
    }
    
    func testIsNilOrEmpty() {
        let test1: String? = "Hello"
        let test2: String? = nil
        let test3: String? = ""
        
        XCTAssertFalse(test1.isNilOrEmpty)
        XCTAssertTrue(test2.isNilOrEmpty)
        XCTAssertTrue(test3.isNilOrEmpty)
    }
    
}

