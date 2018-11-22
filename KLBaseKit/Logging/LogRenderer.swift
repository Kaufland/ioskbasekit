//
//  LogRenderer.swift
//  KLogKit
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol LogRenderer {
    func verbose(_ message: String)
    func debug(_ message: String)
    func info(_ message: String)
    func warn(_ message: String)
    func error(_ message: String)

    func setCustomKey(key: String, value: String?)
    func setCustomKey(key: String, value: Int?)
    func setCustomKey(key: String, value: Float?)
    func setCustomKey(key: String, value: Bool?)
    func setUser(identifier: String?, email: String?, name: String?)
    func recordNonFatal(domain: String, code: Int, customAttributes: [String: AnyObject]?)
}
