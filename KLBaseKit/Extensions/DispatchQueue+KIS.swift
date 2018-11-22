//
//  DispatchQueue+KIS.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 11/05/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension DispatchQueue {

    private static var _onceTracker = [String]()

    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.kaufland.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()

    }

    public class func assureDispatchOnMain(block: @escaping () -> Void) {
        if Thread.isMainThread {
            block()
        } else {
            DispatchQueue.main.async {
                block()
            }
        }
    }
}
