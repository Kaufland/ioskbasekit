//
//  RequestTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

struct RequestTestRequest: Request {
    func decodeResponse(data: Data?, statusCode: Int) throws -> String? {
        return nil
    }
    

    typealias ResponseObject = String
    typealias ErrorResponseObject = String

    let method = RestMethod.post
    var path = "/info.json"
}

class RequestTests: XCTestCase {

    func testBaseValues() {
        let request = RequestTestRequest()

        switch request.authentication {
        case .none:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }

        XCTAssertEqual(request.path, "/info.json")

        XCTAssertEqual(request.method, RestMethod.post)
        XCTAssertNotNil(request.header)
        XCTAssertEqual(request.header.count, 0)
        XCTAssertNotNil(request.query)
        XCTAssertEqual(request.query.count, 0)

        XCTAssertNotNil(request.accept)
        XCTAssertEqual(request.accept, "application/json;charset=utf-8")

        XCTAssertNotNil(request.contentType)
        XCTAssertEqual(request.contentType, "application/json;charset=utf-8")

        XCTAssertNil(request.generateBody())
    }

}
