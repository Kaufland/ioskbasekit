//
//  MultiLogRenderer.swift
//  KLogKit
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public class MultiLogRenderer: LogRenderer {
    let logRenderer: [LogRenderer]

    init(logRenderer: [LogRenderer]) {
        self.logRenderer = logRenderer
    }

    public func verbose(_ message: String) {
        for renderer in logRenderer {
            renderer.verbose(message)
        }
    }

    public func debug(_ message: String) {
        for renderer in logRenderer {
            renderer.debug(message)
        }
    }

    public func info(_ message: String) {
        for renderer in logRenderer {
            renderer.info(message)
        }
    }

    public func warn(_ message: String) {
        for renderer in logRenderer {
            renderer.warn(message)
        }
    }

    public func error(_ message: String) {
        for renderer in logRenderer {
            renderer.error(message)
        }
    }

    public func setCustomKey(key: String, value: String?) {
        for renderer in logRenderer {
            renderer.setCustomKey(key: key, value: value)
        }
    }

    public func setCustomKey(key: String, value: Float?) {
        for renderer in logRenderer {
            renderer.setCustomKey(key: key, value: value)
        }
    }

    public func setCustomKey(key: String, value: Bool?) {
        for renderer in logRenderer {
            renderer.setCustomKey(key: key, value: value)
        }
    }

    public func setCustomKey(key: String, value: Int?) {
        for renderer in logRenderer {
            renderer.setCustomKey(key: key, value: value)
        }
    }

    public func setUser(identifier: String?, email: String?, name: String?) {
        for renderer in logRenderer {
            renderer.setUser(identifier: identifier, email: email, name: name)
        }
    }

    public func recordNonFatal(domain: String, code: Int, customAttributes: [String: AnyObject]? = nil) {
        for renderer in logRenderer {
            renderer.recordNonFatal(domain: domain, code: code, customAttributes: customAttributes)
        }
    }
}
