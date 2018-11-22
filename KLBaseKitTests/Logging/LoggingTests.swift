//
//  LoggingTests.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class LoggingTests: XCTestCase, Logging {
    var renderer: TestLogRenderer?

    override func setUp() {
        renderer = TestLogRenderer()
        Log.renderer = renderer
        Log.logLevel = .verbose
    }

    func testLogTag() {
        XCTAssertEqual(self.logTag, "LoggingTests")
    }

    func testVerbose() {
        logV("test")
        XCTAssertEqual(renderer?.verboseMessage, "LoggingTests: test")
    }

    func testDebug() {
        logD("test1")
        XCTAssertEqual(renderer?.debugMessage, "LoggingTests: test1")
    }

    func testInfo() {
        logI("test2")
        XCTAssertEqual(renderer?.infoMessage, "LoggingTests: test2")
    }

    func testWarn() {
        logW("test3")
        XCTAssertEqual(renderer?.warnMessage, "LoggingTests: test3")
    }

    func testError() {
        logE("test4")
        XCTAssertEqual(renderer?.errorMessage, "LoggingTests: test4")
    }

    func testLog() {
        log(.verbose, string: "test")
        XCTAssertEqual(renderer?.verboseMessage, "LoggingTests: test")
        log(.debug, string: "test1")
        XCTAssertEqual(renderer?.debugMessage, "LoggingTests: test1")
        log(.info, string: "test2")
        XCTAssertEqual(renderer?.infoMessage, "LoggingTests: test2")
        log(.warn, string: "test3")
        XCTAssertEqual(renderer?.warnMessage, "LoggingTests: test3")
        log(.error, string: "test4")
        XCTAssertEqual(renderer?.errorMessage, "LoggingTests: test4")
    }
    
    func testSetUser() {
        setUser(identifier: "i", email: "e", name: "n")
        XCTAssertEqual(renderer?.lastUserName, "n")
        XCTAssertEqual(renderer?.lastUserEmail, "e")
        XCTAssertEqual(renderer?.lastUserIdentifier, "i")
    }
    
    func testCustomKey() {
        setCustomKey(key: "boolKey", value: true)
        XCTAssertEqual(renderer?.lastCustomKey, "boolKey")
        XCTAssertEqual(renderer?.lastCustomValueBool, true)
        
        setCustomKey(key: "floatKey", value: 12.0)
        XCTAssertEqual(renderer?.lastCustomKey, "floatKey")
        XCTAssertEqual(renderer?.lastCustomValueFloat, 12.0)
        
        setCustomKey(key: "intKey", value: 11)
        XCTAssertEqual(renderer?.lastCustomKey, "intKey")
        XCTAssertEqual(renderer?.lastCustomValueInt, 11)
        
        setCustomKey(key: "stringKey", value: "test")
        XCTAssertEqual(renderer?.lastCustomKey, "stringKey")
        XCTAssertEqual(renderer?.lastCustomValueString, "test")
    }
    
    func testNonFatal() {
        LoggingTests.recordNonFatal(domain: "domain", code: 1337, customAttributes: ["hello": "world" as AnyObject])
        
        XCTAssertEqual(renderer?.lastNonFatalDomain, "domain")
        XCTAssertEqual(renderer?.lastNonFatalCode, 1337)
        XCTAssert((renderer?.lastNonFatalCustomAttributes?["hello"] as? String) == "world")
    }

}
