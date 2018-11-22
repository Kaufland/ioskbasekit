//
//  PrepareRequestTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 18/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

struct FullTestRequest: Request {
    func decodeResponse(data: Data?, statusCode: Int) throws -> NSArray? {
        return nil
    }
    
    typealias ResponseObject = NSArray
    typealias ErrorResponseObject = NSDictionary

    let method = RestMethod.post
    var path = "/info.json"
    let accept = "hallo"
    let contentType = "welt"
    let query = ["query": "value"]

    static let bodyData = "hallo welt!".data(using: .utf8)
    func generateBody() -> Data? {
        return FullTestRequest.bodyData
    }

}

class PrepareRequestTests: XCTestCase {

    func testPrepare() {
        let restClient = RestClient(baseUrl: "http://test.de")

        let request = FullTestRequest()
        let authHeader: AuthenticationHeaders = ["Authentication": "Test 123"]
        let authQuery: AuthenticationQueryParameters = ["auth": "test"]

        let expect = expectation(description: "...")

        restClient.prepareRequest(request, authHeaders: authHeader, authParameters: authQuery) { (error, req) in
            XCTAssertNil(error)
            XCTAssertNotNil(req)

            XCTAssertEqual(req?.url?.absoluteString, "http://test.de/info.json?query=value&auth=test")
            XCTAssertEqual(req?.httpMethod, "POST")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Accept"], "hallo")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Content-Type"], "welt")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Authentication"], "Test 123")
            XCTAssertEqual(req?.httpBody, FullTestRequest.bodyData)

            expect.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testPrepareWithQuery() {
        let restClient = RestClient(baseUrl: "http://test.de")

        var request = FullTestRequest()
        request.path += "?hallo=test"
        let authHeader: AuthenticationHeaders = ["Authentication": "Test 123"]
        let authQuery: AuthenticationQueryParameters = ["auth": "test"]

        let expect = expectation(description: "...")

        restClient.prepareRequest(request, authHeaders: authHeader, authParameters: authQuery) { (error, req) in
            XCTAssertNil(error)
            XCTAssertNotNil(req)

            XCTAssertEqual(req?.url?.absoluteString, "http://test.de/info.json?hallo=test&query=value&auth=test")
            XCTAssertEqual(req?.httpMethod, "POST")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Accept"], "hallo")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Content-Type"], "welt")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Authentication"], "Test 123")
            XCTAssertEqual(req?.httpBody, FullTestRequest.bodyData)

            expect.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testPrepareWithFullURL() {
        let restClient = RestClient(baseUrl: "http://test.de")

        var request = FullTestRequest()
        request.path = "http://kaufland.de"
        let authHeader: AuthenticationHeaders = ["Authentication": "Test 123"]
        let authQuery: AuthenticationQueryParameters = ["auth": "test"]

        let expect = expectation(description: "...")

        restClient.prepareRequest(request, authHeaders: authHeader, authParameters: authQuery) { (error, req) in
            XCTAssertNil(error)
            XCTAssertNotNil(req)

            XCTAssertEqual(req?.url?.absoluteString, "http://kaufland.de?query=value&auth=test")
            XCTAssertEqual(req?.httpMethod, "POST")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Accept"], "hallo")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Content-Type"], "welt")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Authentication"], "Test 123")
            XCTAssertEqual(req?.httpBody, FullTestRequest.bodyData)

            expect.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testPrepareWithAppend() {
        let restClient = RestClient(baseUrl: "http://test.de")

        var request = FullTestRequest()
        request.path = "info.json"
        let authHeader: AuthenticationHeaders = ["Authentication": "Test 123"]
        let authQuery: AuthenticationQueryParameters = ["auth": "test"]

        let expect = expectation(description: "...")

        restClient.prepareRequest(request, authHeaders: authHeader, authParameters: authQuery) { (error, req) in
            XCTAssertNil(error)
            XCTAssertNotNil(req)

            XCTAssertEqual(req?.url?.absoluteString, "http://test.de/info.json?query=value&auth=test")
            XCTAssertEqual(req?.httpMethod, "POST")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Accept"], "hallo")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Content-Type"], "welt")
            XCTAssertEqual(req?.allHTTPHeaderFields?["Authentication"], "Test 123")
            XCTAssertEqual(req?.httpBody, FullTestRequest.bodyData)

            expect.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testPrepareWithFailure() {
        let restClient = RestClient(baseUrl: "jogi-bär")

        var request = FullTestRequest()
        request.path = "info.json"
        let authHeader: AuthenticationHeaders = ["Authentication": "Test 123"]
        let authQuery: AuthenticationQueryParameters = ["auth": "test"]

        let expect = expectation(description: "...")

        restClient.prepareRequest(request, authHeaders: authHeader, authParameters: authQuery) { (error, req) in
            XCTAssertNotNil(error)
            XCTAssertNil(req)

            switch error! {
            case .badUrl:
                expect.fulfill()
            default:
                break
            }

        }

        waitForExpectations(timeout: 1.0) { _ in

        }

    }
}
