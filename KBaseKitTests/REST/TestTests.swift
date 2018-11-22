//
//  TestTests.swift
//  KRestKit
//
//  Created by Markus Troßbach on 11/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest

@testable import KBaseKit

struct TestRequest: Request {
    func decodeResponse(data: Data?, statusCode: Int) throws -> NSArray? {
        return nil
    }
    
    typealias ResponseObject = NSArray
    typealias ErrorResponseObject = NSDictionary

    let method = RestMethod.get
    let path = "/api/v1/stores"
    let authentication = RestAuthentication.custom(nil)
}

class TestTests: XCTestCase, RestClientAuthenticationDelegate {
    func generateAuthenticationInformation<T>(_ request: T, identifier: String?, completion: @escaping (AuthenticationHeaders?, AuthenticationQueryParameters?) -> Void) where T : Request {
        completion(["Authorization": "Basic S0lTLUtMQVBQOkRyZWNrc3pldWdfMzUyOS1BY2h0c3BubmVy"], nil)

    }
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        let expect = expectation(description: "...")

        let client = RestClient(baseUrl: "https://app.kaufland.net")
        client.authenticationDelegate = self

        let request = TestRequest()

        client.performRequest(request) { (result) in
            switch result {
            case .error(let errorObject, _):
                print("\(errorObject)")
            case .exception(let error, _):
                print("\(error)")
            case .success(let result, _):
                //print("\(result)")
                print("success! \(result?.count)")
            }

            expect.fulfill()
        }

        waitForExpectations(timeout: 10.0) { _ in

        }
    }

}
