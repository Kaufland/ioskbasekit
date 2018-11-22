//
//  NSLogRendererTests.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class TestNSLogRendererRenderer: NSLogRenderer {
    var lastMessage: String?
    internal override func log(_ message: String) {
        lastMessage = message
        super.log(message)
    }
}

class NSLogRendererTests: XCTestCase {
    var renderer: TestNSLogRendererRenderer?

    override func setUp() {
        renderer = TestNSLogRendererRenderer()
        Log.renderer = renderer
        Log.logLevel = .verbose
    }

    override func tearDown() {
        Log.renderer = NSLogRenderer()
    }

    func testVerbose() {
        Log.v("test")
        XCTAssertEqual(renderer?.lastMessage, "[V] test")
        Log.v("hallo%@", args: "Welt")
        XCTAssertEqual(renderer?.lastMessage, "[V] halloWelt")
    }

    func testDebug() {
        Log.d("test1")
        XCTAssertEqual(renderer?.lastMessage, "[D] test1")
        Log.d("hallo%@", args: "Welt5")
        XCTAssertEqual(renderer?.lastMessage, "[D] halloWelt5")
    }

    func testInfo() {
        Log.i("test2")
        XCTAssertEqual(renderer?.lastMessage, "[I] test2")
        Log.i("hallo%@", args: "Welt6")
        XCTAssertEqual(renderer?.lastMessage, "[I] halloWelt6")
    }

    func testWarn() {
        Log.w("test3")
        XCTAssertEqual(renderer?.lastMessage, "[W] test3")
        Log.w("hallo%@", args: "Welt7")
        XCTAssertEqual(renderer?.lastMessage, "[W] halloWelt7")
    }

    func testError() {
        Log.e("test4")
        XCTAssertEqual(renderer?.lastMessage, "[E] test4")
        Log.e("hallo%@", args: "Welt8")
        XCTAssertEqual(renderer?.lastMessage, "[E] halloWelt8")
    }
    
    func testSetUser() {
        Log.setUser(identifier: "i", email: "e", name: "n")
    }
    
    func testCustomKey() {
        Log.setCustomKey(key: "boolKey", value: true)
        Log.setCustomKey(key: "floatKey", value: 12.0)
        Log.setCustomKey(key: "intKey", value: 11)
        Log.setCustomKey(key: "stringKey", value: "test")
    }
    
    func testNonFatal() {
        Log.recordNonFatal(domain: "domain", code: 1337, customAttributes: ["hello": "world" as AnyObject])
    }

}
