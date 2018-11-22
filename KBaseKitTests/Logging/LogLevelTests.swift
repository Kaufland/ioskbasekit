//
//  LogLevelTest.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

class LogLevelTest: XCTestCase {
    var renderer: TestNSLogRendererRenderer?

    override func setUp() {
        renderer = TestNSLogRendererRenderer()
        Log.renderer = renderer
    }

    override func tearDown() {
        Log.renderer = NSLogRenderer()
    }

    func testVerbose() {
        Log.logLevel = .verbose
        Log.e("test")

        Log.v("test1")
        XCTAssertEqual(renderer?.lastMessage, "[V] test1")
        Log.d("test2")
        XCTAssertEqual(renderer?.lastMessage, "[D] test2")
        Log.i("test3")
        XCTAssertEqual(renderer?.lastMessage, "[I] test3")
        Log.w("test4")
        XCTAssertEqual(renderer?.lastMessage, "[W] test4")
        Log.e("test5")
        XCTAssertEqual(renderer?.lastMessage, "[E] test5")
    }

    func testDebug() {
        Log.logLevel = .debug
        Log.e("test")

        Log.v("test1")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.d("test2")
        XCTAssertEqual(renderer?.lastMessage, "[D] test2")
        Log.i("test3")
        XCTAssertEqual(renderer?.lastMessage, "[I] test3")
        Log.w("test4")
        XCTAssertEqual(renderer?.lastMessage, "[W] test4")
        Log.e("test5")
        XCTAssertEqual(renderer?.lastMessage, "[E] test5")
    }

    func testInfo() {
        Log.logLevel = .info
        Log.e("test")

        Log.v("test1")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.d("test2")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.i("test3")
        XCTAssertEqual(renderer?.lastMessage, "[I] test3")
        Log.w("test4")
        XCTAssertEqual(renderer?.lastMessage, "[W] test4")
        Log.e("test5")
        XCTAssertEqual(renderer?.lastMessage, "[E] test5")
    }

    func testWarn() {
        Log.logLevel = .warn
        Log.e("test")

        Log.v("test1")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.d("test2")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.i("test3")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.w("test4")
        XCTAssertEqual(renderer?.lastMessage, "[W] test4")
        Log.e("test5")
        XCTAssertEqual(renderer?.lastMessage, "[E] test5")
    }

    func testError() {
        Log.logLevel = .error
        Log.e("test")

        Log.v("test1")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.d("test2")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.i("test3")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.w("test4")
        XCTAssertEqual(renderer?.lastMessage, "[E] test")
        Log.e("test5")
        XCTAssertEqual(renderer?.lastMessage, "[E] test5")
    }

    func testComparator() {
        XCTAssertEqual(LogLevel.debug, LogLevel.debug)

        XCTAssertGreaterThan(LogLevel.info, LogLevel.debug)
        XCTAssertGreaterThanOrEqual(LogLevel.info, LogLevel.info)

        XCTAssertLessThan(LogLevel.warn, LogLevel.error)
        XCTAssertLessThanOrEqual(LogLevel.verbose, LogLevel.verbose)
    }

}
