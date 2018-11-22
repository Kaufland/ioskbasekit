//
//  KLogKitTests.swift
//  KLogKitTests
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class TestLogRenderer: LogRenderer {
    var lastNonFatalDomain: String?
    var lastNonFatalCode: Int?
    var lastNonFatalCustomAttributes: [String: AnyObject]?
    
    func recordNonFatal(domain: String, code: Int, customAttributes: [String : AnyObject]?) {
        lastNonFatalDomain = domain
        lastNonFatalCode = code
        lastNonFatalCustomAttributes = customAttributes
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

    var lastUserIdentifier: String?
    var lastUserEmail: String?
    var lastUserName: String?
    
    func setUser(identifier: String?, email: String?, name: String?) {
        lastUserIdentifier = identifier
        lastUserEmail = email
        lastUserName = name
    }

    var lastCustomKey: String?
    var lastCustomValueInt: Int?
    var lastCustomValueBool: Bool?
    var lastCustomValueFloat: Float?
    var lastCustomValueString: String?
    
    func setCustomKey(key: String, value: Int?) {
        lastCustomKey = key
        lastCustomValueInt = value
    }

    func setCustomKey(key: String, value: Bool?) {
        lastCustomKey = key
        lastCustomValueBool = value
    }

    func setCustomKey(key: String, value: Float?) {
        lastCustomKey = key
        lastCustomValueFloat = value
    }

    func setCustomKey(key: String, value: String?) {
        lastCustomKey = key
        lastCustomValueString = value
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
    
    func testSetUser() {
        Log.setUser(identifier: "i", email: "e", name: "n")
        XCTAssertEqual(renderer?.lastUserName, "n")
        XCTAssertEqual(renderer?.lastUserEmail, "e")
        XCTAssertEqual(renderer?.lastUserIdentifier, "i")
    }
    
    func testCustomKey() {
        Log.setCustomKey(key: "boolKey", value: true)
        XCTAssertEqual(renderer?.lastCustomKey, "boolKey")
        XCTAssertEqual(renderer?.lastCustomValueBool, true)
        
        Log.setCustomKey(key: "floatKey", value: 12.0)
        XCTAssertEqual(renderer?.lastCustomKey, "floatKey")
        XCTAssertEqual(renderer?.lastCustomValueFloat, 12.0)
        
        Log.setCustomKey(key: "intKey", value: 11)
        XCTAssertEqual(renderer?.lastCustomKey, "intKey")
        XCTAssertEqual(renderer?.lastCustomValueInt, 11)
        
        Log.setCustomKey(key: "stringKey", value: "test")
        XCTAssertEqual(renderer?.lastCustomKey, "stringKey")
        XCTAssertEqual(renderer?.lastCustomValueString, "test")
    }
    
    func testNonFatal() {
        Log.recordNonFatal(domain: "domain", code: 1337, customAttributes: ["hello": "world" as AnyObject])
        
        XCTAssertEqual(renderer?.lastNonFatalDomain, "domain")
        XCTAssertEqual(renderer?.lastNonFatalCode, 1337)
        XCTAssert((renderer?.lastNonFatalCustomAttributes?["hello"] as? String) == "world")
    }

}
