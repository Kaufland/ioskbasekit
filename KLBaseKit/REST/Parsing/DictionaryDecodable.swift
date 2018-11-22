//
//  JSONDecodable.swift
//  KAppKit
//
//  Created by Markus Troßbach on 02/12/2016.
//  Copyright © 2016 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol DictionaryDecodable {
    static func fromDictionary(dictionary: [String: Any]?) -> Self?
}

public protocol StringDecodable {
    static func fromString(string: String?) -> Self?
}

infix operator <<?: AdditionPrecedence

public func <<? <T: Any>(lhs: inout T, rhs: Any?) {
    if let ImportableType = T.self as? DictionaryDecodable.Type {
        if let object = ImportableType.fromDictionary(dictionary: rhs as? [String: Any]) as? T {
            lhs = object
        }
    } else if let ImportableType = T.self as? StringDecodable.Type {
        if let object = ImportableType.fromString(string: rhs as? String) as? T {
            lhs = object
        }
    } else {
        lhs = rhs as? T ?? lhs
    }
}

public func <<? <T: Any>(lhs: inout T?, rhs: Any?) {
    if let ImportableType = T.self as? DictionaryDecodable.Type {
        if let object = ImportableType.fromDictionary(dictionary: rhs as? [String: Any]) as? T {
            lhs = object
        }
    } else if let ImportableType = T.self as? StringDecodable.Type {
        if let object = ImportableType.fromString(string: rhs as? String) as? T {
            lhs = object
        }
    } else {
        lhs = rhs as? T ?? lhs
    }
}

public func <<? <T: DictionaryDecodable>(lhs: inout [T], rhs: Any?) {
    var array = [T]()
    if let rhs = rhs as? [AnyObject] {
        for item in rhs {
            if let item = T.fromDictionary(dictionary: item as? [String: Any]) {
                array.append(item)
            }
        }
    }
    lhs = array
}

public func <<? <T: DictionaryDecodable>(lhs: inout [T]?, rhs: Any?) {
    var array = [T]()
    if let rhs = rhs as? [AnyObject] {
        for item in rhs {
            if let item = T.fromDictionary(dictionary: item as? [String: Any]) {
                array.append(item)
            }
        }
    }
    lhs = array
}

public func <<? <T: StringDecodable>(lhs: inout [T], rhs: Any?) {
    var array = [T]()
    if let rhs = rhs as? [String] {
        for item in rhs {
            if let item = T.fromString(string: item) {
                array.append(item)
            }
        }
    }
    lhs = array
}

public func <<? <T: StringDecodable>(lhs: inout [T]?, rhs: Any?) {
    var array = [T]()
    if let rhs = rhs as? [String] {
        for item in rhs {
            if let item = T.fromString(string: item) {
                array.append(item)
            }
        }
    }
    lhs = array
}
