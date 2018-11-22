//
//  AuthenticationTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 18/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

struct AuthTestRequest: Request {
    func decodeResponse(data: Data?, statusCode: Int) throws -> NSArray? {
        return nil
    }
    
    typealias ResponseObject = NSArray
    typealias ErrorResponseObject = NSDictionary

    let method = RestMethod.post
    var path = "/info.json"
    var authentication = RestAuthentication.custom("identifier")

}

class AuthenticationTests: XCTestCase, RestClientAuthenticationDelegate {
    func generateAuthenticationInformation<T>(_ request: T, identifier: String?, completion: @escaping (AuthenticationHeaders?, AuthenticationQueryParameters?) -> Void) where T : Request {
        XCTAssertNotNil(identifier)
        XCTAssertEqual(identifier, "identifier")
        expect!.fulfill()
    }
    

    var expect: XCTestExpectation?

    func testCustom() {
        let restClient = RestClient(baseUrl: "http://test.de")
        restClient.authenticationDelegate = self
        let request = AuthTestRequest()

        expect = expectation(description: "...")

        restClient.prepareRequestAuthenticationInformation(request) { (_, _, _) in

        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testNone() {
        let restClient = RestClient(baseUrl: "http://test.de")
        restClient.authenticationDelegate = self
        var request = AuthTestRequest()
        request.authentication = .none

        let exp = expectation(description: "...")

        restClient.prepareRequestAuthenticationInformation(request) { (error, headers, query) in
            XCTAssertNil(headers)
            XCTAssertNil(query)
            XCTAssertNil(error)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }

    }

    func testCustomWithDelegate() {
        let restClient = RestClient(baseUrl: "http://test.de")
        let request = AuthTestRequest()

        let exp = expectation(description: "...")

        restClient.prepareRequestAuthenticationInformation(request) { (error, headers, query) in
            XCTAssertNil(headers)
            XCTAssertNil(query)
            XCTAssertNotNil(error)

            switch error! {
            case .authenticationMissing:
                exp.fulfill()
            default:
                break
            }
        }

        waitForExpectations(timeout: 1) { _ in

        }

    }

}
