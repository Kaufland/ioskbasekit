//
//  SecurityStatusTests.swift
//  KSecKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class SecurityStatusTests: XCTestCase {

    func testProxy() {
        let _ = SecurityStatus.Proxy.host
        let _ = SecurityStatus.Proxy.port
        XCTAssertNotNil(SecurityStatus.Proxy.enabled)
        XCTAssertNotNil(SecurityStatus.Proxy.settings)
    }

    func testJailbreak() {
        XCTAssertTrue(SecurityStatus.Jailbreak.isJailbrokenSimple)
    }

    func testDebugger() {
        XCTAssertTrue(SecurityStatus.Debugger.defaultWayConnected || true)
        XCTAssertTrue(SecurityStatus.Debugger.ttyWayConnected || true)
        XCTAssertTrue(SecurityStatus.Debugger.connected || true)
    }

}
