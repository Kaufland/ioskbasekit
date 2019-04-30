//
//  Optional+KIS.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol StringType { var get: String { get } }
extension String: StringType { public var get: String { return self } }

public protocol IntType { var get: Int { get } }
extension Int: IntType { public var get: Int { return self } }

public extension Optional where Wrapped: StringType {

    var safeVal: String {
        return self?.get ?? "?"
    }

}

public extension Optional where Wrapped: IntType {

    var safeVal: Int {
        return self?.get ?? 0
    }

}

public extension Optional where Wrapped == String {

    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }

}
