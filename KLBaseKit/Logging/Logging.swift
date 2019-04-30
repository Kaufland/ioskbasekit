//
//  Logging.swift
//  KLogKit
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol Logging {
    var logTag: String { get }
    func logV(_ string: String)
    func logD(_ string: String)
    func logI(_ string: String)
    func logW(_ string: String)
    func logE(_ string: String)
    func log(_ loglevel: LogLevel, string: String)
}

public extension Logging {
    var logTag: String {
        return String(describing: type(of: self))
    }

    func logV(_ string: String) {
        Log.v("\(logTag): \(string)")
    }

    func logD(_ string: String) {
        Log.d("\(logTag): \(string)")
    }

    func logI(_ string: String) {
        Log.i("\(logTag): \(string)")
    }

    func logW(_ string: String) {
        Log.w("\(logTag): \(string)")
    }

    func logE(_ string: String) {
        Log.e("\(logTag): \(string)")
    }

    func setCustomKey(key: String, value: String?) {
        Log.setCustomKey(key: key, value: value)
    }

    func setCustomKey(key: String, value: Int?) {
        Log.setCustomKey(key: key, value: value)
    }

    func setCustomKey(key: String, value: Float?) {
        Log.setCustomKey(key: key, value: value)
    }

    func setCustomKey(key: String, value: Bool?) {
        Log.setCustomKey(key: key, value: value)
    }

    func setUser(identifier: String?, email: String?, name: String?) {
        Log.setUser(identifier: identifier, email: email, name: name)
    }

    static func recordNonFatal(domain: String, code: Int, customAttributes: [String: AnyObject]? = nil) {
        Log.recordNonFatal(domain: domain, code: code, customAttributes: customAttributes)
    }

    func log(_ loglevel: LogLevel, string: String) {
        switch loglevel {
        case .debug:
            logD(string)
        case .error:
            logE(string)
        case .info:
            logI(string)
        case .verbose:
            logV(string)
        case .warn:
            logW(string)
        }
    }
}
