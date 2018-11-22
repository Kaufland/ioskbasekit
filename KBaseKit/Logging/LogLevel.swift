//
//  LogLevel.swift
//  KLogKit
//
//  Created by Markus Troßbach on 23/03/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public enum LogLevel: Int, Comparable {
    case verbose = 0
    case debug = 1
    case info = 2
    case warn = 3
    case error = 4
}

public func == (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue == rhs.rawValue
}

public func >= (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue >= rhs.rawValue
}

public func <= (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue <= rhs.rawValue
}

public func < (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue < rhs.rawValue
}

public func > (lhs: LogLevel, rhs: LogLevel) -> Bool {
    return lhs.rawValue > rhs.rawValue
}
