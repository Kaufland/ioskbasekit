//
//  Array+KIS.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 07.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension Array {
    func safeRef (_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }
}
