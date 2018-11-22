//
//  HTTPURLResponseKISTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class HTTPURLResponseKISTests: XCTestCase {

    func testHeaders() {
        let response = HTTPURLResponse(url: URL(string: "http://localhost")!, statusCode: 200, httpVersion: "1", headerFields: ["Test": "hallo"])
        XCTAssertNotEqual(response?.allHeaderFields["test"] as? String, "hallo")
        XCTAssertEqual(response?.lowercasedHeaders()["test"] as? String, "hallo")
    }

}
