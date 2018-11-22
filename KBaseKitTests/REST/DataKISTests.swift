//
//  DataKISTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

class DataKISTests: XCTestCase {

    func testExample() {
        let data = "hallo".data(using: String.Encoding.utf8)!
        XCTAssertEqual(data.utf8String(), "hallo")
    }

}
