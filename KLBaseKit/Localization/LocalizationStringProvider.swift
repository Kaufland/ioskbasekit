//
//  LocalizationStringProvider.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 16/05/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol LocalizationStringProvider {
    static var defaultTableName: String { get }
    static var bundle: Bundle { get }

    static func localizedString(key: String, comment: String) -> String
    static func localizedString(key: String, tableName: String?, comment: String) -> String
    static func localizedStringWithFormat(key: String, comment: String, arguments: CVarArg...) -> String
    static func localizedStringWithFormat(key: String, tableName: String?, comment: String, arguments: CVarArg...) -> String
}

public extension LocalizationStringProvider {
    private static func privateLocalizedString(key: String, tableName: String?, comment: String) -> String! {
        return NSLocalizedString(key, tableName: tableName != nil ? tableName : defaultTableName, bundle: bundle, comment: comment)
    }

    static func localizedString(key: String, comment: String) -> String {
        return localizedString(key: key, tableName: nil, comment: comment)
    }

    static func localizedString(key: String, tableName: String?, comment: String) -> String {
        let string = privateLocalizedString(key: key, tableName: tableName, comment: comment)
        if let string = string {
            return string
        } else {
            Log.recordNonFatal(domain: "LocalizedStringBug", code: 0, customAttributes: [
                "key": key as AnyObject
                ])
            return "????"
        }
    }

    static func localizedStringWithFormat(key: String, comment: String, arguments: CVarArg...) -> String {
        return localizedStringWithFormat(key: key, tableName: nil, comment: comment, arguments: arguments)
    }

    static func localizedStringWithFormat(key: String, tableName: String?, comment: String, arguments: CVarArg...) -> String {
        return String.localizedStringWithFormat(localizedString(key: key, tableName: tableName, comment: comment), arguments)
    }
}
