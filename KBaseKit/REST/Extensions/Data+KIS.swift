//
//  Data+KIS.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension Data {
    func utf8String() -> String? {
        return String(data: self, encoding: .utf8)
    }
}
