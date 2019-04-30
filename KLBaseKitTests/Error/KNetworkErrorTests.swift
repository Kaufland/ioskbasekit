//
//  KNetworkErrorTests.swift
//  KLBaseKitTests
//
//  Created by Markus Troßbach on 26.11.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KLBaseKit

class KNetworkErrorTests: XCTestCase {
    
    func testTimeout() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .timedOut:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testNoInternet() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .noInternet:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCallIsActive() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCallIsActive, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .callIsActive:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testInternationalRoaming() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorInternationalRoamingOff, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .internationalRoamingOff:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testDataNotAllowed() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorDataNotAllowed, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .dataNotAllowed:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCancelled() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .userCancelled:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testBadUrl() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorBadURL, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .badUrl:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testDNSLookupFailed() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorDNSLookupFailed, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .dnsLookupFailed:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCannotFindHost() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorCannotFindHost, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .dnsLookupFailed:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testConnectionLost() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNetworkConnectionLost, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .connectionLost:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCertHasBadDate() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorServerCertificateHasBadDate, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .serverCertificateUntrusted:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCertUntrusted() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorServerCertificateUntrusted, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .serverCertificateUntrusted:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCertNotYetValid() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorServerCertificateNotYetValid, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .serverCertificateUntrusted:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testCertUnknownRoot() {
        let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorServerCertificateHasUnknownRoot, userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .serverCertificateUntrusted:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testConnectionAbort() {
        let error = NSError(domain: NSPOSIXErrorDomain, code: Int(ECONNABORTED), userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .connectionAbort:
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
    
    func testElse() {
        let error = NSError(domain: NSPOSIXErrorDomain, code: Int(EBADMSG), userInfo: nil)
        switch(KNetworkError.convert(error)) {
        case .generic( _):
            XCTAssertTrue(true)
        default:
            XCTAssertTrue(false)
        }
    }
}

