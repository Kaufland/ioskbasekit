//
//  FileManagerTests.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 23.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class FileManagerTests: XCTestCase {
    
    func testPaths() {
        let cache = FileManager.cachesPath
        let doc = FileManager.documentsPath
        
        XCTAssertNotNil(cache)
        XCTAssertTrue(cache.count > 0)
        XCTAssertNotNil(doc)
        XCTAssertTrue(doc.count > 0)
    }
    

}

