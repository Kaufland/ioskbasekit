//
//  RestClientTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 18/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

class RestClientTests: XCTestCase {

    func testOperationCount() {
        let restClient = RestClient(baseUrl: "http://test.de")

        restClient.maxConcurrentRequests = 1337
        XCTAssertEqual(restClient.maxConcurrentRequests, 1337)

    }

}
