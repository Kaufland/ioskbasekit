//
//  NSLogRenderer.swift
//  KLogKit
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public class NSLogRenderer: LogRenderer {
    public func verbose(_ message: String) {
        log("[V] \(message)")
    }

    public func debug(_ message: String) {
        log("[D] \(message)")
    }

    public func info(_ message: String) {
        log("[I] \(message)")
    }

    public func warn(_ message: String) {
        log("[W] \(message)")
    }

    public func error(_ message: String) {
        log("[E] \(message)")
    }

    internal func log(_ message: String) {
        NSLog(message)
    }

    public func setCustomKey(key: String, value: Int?) {
        //do nothing
    }

    public func setCustomKey(key: String, value: Bool?) {
        //do nothing
    }

    public func setCustomKey(key: String, value: Float?) {
        //do nothing
    }

    public func setCustomKey(key: String, value: String?) {
        //do nothing
    }

    public func setUser(identifier: String?, email: String?, name: String?) {
        //do nothing
    }

    public func recordNonFatal(domain: String, code: Int, customAttributes: [String: AnyObject]? = nil) {
        //do nothing
    }
}
