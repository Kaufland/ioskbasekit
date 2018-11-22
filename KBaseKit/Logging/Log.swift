//
//  Log.swift
//  EFoodKit
//
//  Created by Markus Troßbach on 07.06.16.
//
//

import Foundation

final public class Log {
    public static var renderer: LogRenderer? = NSLogRenderer()

    public static var logLevel = LogLevel.verbose

    public static func v(_ format: String, args: CVarArg...) {
        if logLevel <= .verbose {
            renderer?.verbose(String(format: format, arguments: args))
        }
    }

    public static func d(_ format: String, args: CVarArg...) {
        if logLevel <= .debug {
            renderer?.debug(String(format: format, arguments: args))
        }
    }
    public static func i(_ format: String, args: CVarArg...) {
        if logLevel <= .info {
            renderer?.info(String(format: format, arguments: args))
        }
    }
    public static func w(_ format: String, args: CVarArg...) {
        if logLevel <= .warn {
            renderer?.warn(String(format: format, arguments: args))
        }
    }
    public static func e(_ format: String, args: CVarArg...) {
        if logLevel <= .error {
            renderer?.error(String(format: format, arguments: args))
        }
    }

    public static func setCustomKey(key: String, value: String?) {
        renderer?.setCustomKey(key: key, value: value)
    }

    public static func setCustomKey(key: String, value: Int?) {
        renderer?.setCustomKey(key: key, value: value)
    }

    public static func setCustomKey(key: String, value: Float?) {
        renderer?.setCustomKey(key: key, value: value)
    }

    public static func setCustomKey(key: String, value: Bool?) {
        renderer?.setCustomKey(key: key, value: value)
    }

    public static func setUser(identifier: String? = nil, email: String? = nil, name: String? = nil) {
        renderer?.setUser(identifier: identifier, email: email, name: name)
    }

    public static func recordNonFatal(domain: String, code: Int, customAttributes: [String: AnyObject]? = nil) {
        renderer?.recordNonFatal(domain: domain, code: code, customAttributes: customAttributes)
    }
}
