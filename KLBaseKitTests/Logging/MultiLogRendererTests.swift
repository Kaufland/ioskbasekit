//
//  MultiLogRendererTests.swift
//  KLogKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class MultiLogRendererTests: XCTestCase {
    var renderer1: TestLogRenderer! = nil
    var renderer2: TestLogRenderer! = nil
    var multiRenderer: MultiLogRenderer! = nil

    override func setUp() {
        renderer1 = TestLogRenderer()
        renderer2 = TestLogRenderer()
        multiRenderer = MultiLogRenderer(logRenderer: [renderer1, renderer2])

        Log.renderer = multiRenderer
        Log.logLevel = .verbose
    }

    func testVerbose() {
        Log.v("test")
        XCTAssertEqual(renderer1?.verboseMessage, "test")
        XCTAssertEqual(renderer2?.verboseMessage, "test")
        Log.v("hallo%@", args: "Welt")
        XCTAssertEqual(renderer1?.verboseMessage, "halloWelt")
        XCTAssertEqual(renderer2?.verboseMessage, "halloWelt")
    }

    func testDebug() {
        Log.d("test1")
        XCTAssertEqual(renderer1?.debugMessage, "test1")
        XCTAssertEqual(renderer2?.debugMessage, "test1")
        Log.d("hallo%@", args: "Welt5")
        XCTAssertEqual(renderer1?.debugMessage, "halloWelt5")
        XCTAssertEqual(renderer2?.debugMessage, "halloWelt5")
    }

    func testInfo() {
        Log.i("test2")
        XCTAssertEqual(renderer1?.infoMessage, "test2")
        XCTAssertEqual(renderer2?.infoMessage, "test2")
        Log.i("hallo%@", args: "Welt6")
        XCTAssertEqual(renderer1?.infoMessage, "halloWelt6")
        XCTAssertEqual(renderer2?.infoMessage, "halloWelt6")
    }

    func testWarn() {
        Log.w("test3")
        XCTAssertEqual(renderer1?.warnMessage, "test3")
        XCTAssertEqual(renderer2?.warnMessage, "test3")
        Log.w("hallo%@", args: "Welt7")
        XCTAssertEqual(renderer1?.warnMessage, "halloWelt7")
        XCTAssertEqual(renderer2?.warnMessage, "halloWelt7")
    }

    func testError() {
        Log.e("test4")
        XCTAssertEqual(renderer1?.errorMessage, "test4")
        XCTAssertEqual(renderer2?.errorMessage, "test4")
        Log.e("hallo%@", args: "Welt8")
        XCTAssertEqual(renderer1?.errorMessage, "halloWelt8")
        XCTAssertEqual(renderer2?.errorMessage, "halloWelt8")
    }}
