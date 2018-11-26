//
//  DispatchQueueTests.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 26.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class DispatchQueueTets: XCTestCase {
    
    func testOnce() {
        let token = "token"
        
        DispatchQueue.once(token: token) {
            XCTAssertTrue(true);
        }
        
        DispatchQueue.once(token: token) {
            XCTAssertTrue(false);
        }
        
        XCTAssertTrue(true);
    }
    
    
}
