//
//  FileManager+KIS.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 02/06/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension FileManager {
    public class var cachesPath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first ?? ""
    }

    public class var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
    }
}
