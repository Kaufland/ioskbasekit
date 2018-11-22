//
//  LoggingTests.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

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

}
