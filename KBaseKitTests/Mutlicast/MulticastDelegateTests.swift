//
//  MulticastDelegateTests.swift
//  KCoreKitTests
//
//  Created by Markus Troßbach on 23.10.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import XCTest
@testable import KBaseKit

protocol MulticastTestProtocol: class {
    func test()
}

class MulticastTestObject: MulticastTestProtocol {
    var block: (() -> ())?
    func test() {
        block?()
    }
}

class MulticastDelegateTests: XCTestCase {
    func testDelegatesChanged() {
        let multicastDelegates = MulticastDelegate<MulticastTestProtocol>()
        let object = MulticastTestObject()
        
        let expect1 = expectation(description: "delegate added")
        let expect2 = expectation(description: "delegate removed")
        
        multicastDelegates.delegatesChanged = { delegates, delegate in
            if delegate != nil {
                expect1.fulfill()
            } else {
                expect2.fulfill()
            }
        }
       
        multicastDelegates.add(delegate: object)
        multicastDelegates.remove(delegate: object)
        waitForExpectations(timeout: 1.0) { _ in
            
        }
    }
    
    func testInvoke() {
        let multicastDelegates = MulticastDelegate<MulticastTestProtocol>()
        let object = MulticastTestObject()
        
        let expect1 = expectation(description: "delegate added")
        
        object.block = {
            if !Thread.isMainThread {
                expect1.fulfill()
            }
        }
        multicastDelegates.add(delegate: object)
        
        XCTAssertEqual(multicastDelegates.count, 1)
        
        DispatchQueue(label: "queuename").async {
            multicastDelegates.invoke { delegate in
                delegate.test()
            }
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            
        }
    }
    
    func testInvokeOnMain() {
        let multicastDelegates = MulticastDelegate<MulticastTestProtocol>()
        let object = MulticastTestObject()
        
        let expect1 = expectation(description: "delegate added")
        
        object.block = {
            if Thread.isMainThread {
                expect1.fulfill()
            }
        }
        multicastDelegates.add(delegate: object)
        
        DispatchQueue(label: "queuename").async {
            multicastDelegates.invokeOnMain { delegate in
                delegate.test()
            }
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            
        }
    }
    
    func testWeakBehavior() {
        let multicastDelegates = MulticastDelegate<MulticastTestProtocol>()
        var object: MulticastTestObject? = MulticastTestObject()
        
        let expect1 = expectation(description: "delegate added")
        
        multicastDelegates.delegatesChanged = { delegates, delegate in
            if delegate != nil {
                expect1.fulfill()
            }
        }
        
        if let object = object {
            multicastDelegates.add(delegate: object)
        }
        object = nil
        multicastDelegates.invoke { delegate in
            delegate.test()
        }
        
        XCTAssertEqual(multicastDelegates.count, 0)
        
        waitForExpectations(timeout: 1.0) { _ in
            
        }
    }
}
