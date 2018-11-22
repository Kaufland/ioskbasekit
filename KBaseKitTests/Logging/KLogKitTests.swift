//
//  KLogKitTests.swift
//  KLogKitTests
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

class TestLogRenderer: LogRenderer {
    func recordNonFatal(domain: String, code: Int, customAttributes: [String : AnyObject]?) {
        //nothing
    }
    
    var verboseMessage: String?
    func verbose(_ message: String) {
        self.verboseMessage = message
    }

    var debugMessage: String?
    func debug(_ message: String) {
        self.debugMessage = message
    }

    var infoMessage: String?
    func info(_ message: String) {
        self.infoMessage = message
    }

    var warnMessage: String?
    func warn(_ message: String) {
        self.warnMessage = message
    }

    var errorMessage: String?
    func error(_ message: String) {
        self.errorMessage = message
    }

    func setUser(identifier: String?, email: String?, name: String?) {
        //nothing
    }

    func setCustomKey(key: String, value: Int?) {
        //nothing
    }

    func setCustomKey(key: String, value: Bool?) {
        //nothing
    }

    func setCustomKey(key: String, value: Float?) {
        //nothing
    }

    func setCustomKey(key: String, value: String?) {
        //nothing
    }
}

class KLogKitTests: XCTestCase {
    var renderer: TestLogRenderer?

    override func setUp() {
        renderer = TestLogRenderer()
        Log.renderer = renderer
        Log.logLevel = .verbose
    }

    func testVerbose() {
        Log.v("test")
        XCTAssertEqual(renderer?.verboseMessage, "test")
        Log.v("hallo%@", args: "Welt")
        XCTAssertEqual(renderer?.verboseMessage, "halloWelt")
    }

    func testDebug() {
        Log.d("test1")
        XCTAssertEqual(renderer?.debugMessage, "test1")
        Log.d("hallo%@", args: "Welt5")
        XCTAssertEqual(renderer?.debugMessage, "halloWelt5")
    }

    func testInfo() {
        Log.i("test2")
        XCTAssertEqual(renderer?.infoMessage, "test2")
        Log.i("hallo%@", args: "Welt6")
        XCTAssertEqual(renderer?.infoMessage, "halloWelt6")
    }

    func testWarn() {
        Log.w("test3")
        XCTAssertEqual(renderer?.warnMessage, "test3")
        Log.w("hallo%@", args: "Welt7")
        XCTAssertEqual(renderer?.warnMessage, "halloWelt7")
    }

    func testError() {
        Log.e("test4")
        XCTAssertEqual(renderer?.errorMessage, "test4")
        Log.e("hallo%@", args: "Welt8")
        XCTAssertEqual(renderer?.errorMessage, "halloWelt8")
    }

}
