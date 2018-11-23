//
//  ExceptionTest.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class ExecptionTests: XCTestCase {

     func testCatch() {
        let exp = expectation(description: "Exception caught")
        
        do {
            try ObjC.catchException {
                let test = ThrowingClass()
                test.throwException()
            }
        } catch {
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10.0) { _ in
            
        }
    }
    
    func testDoNotCatch() {
        do {
            try ObjC.catchException {
                let test = ThrowingClass()
                test.noThrowException()
            }
        } catch {
            XCTFail("exception not expected!")
        }
    }
}
