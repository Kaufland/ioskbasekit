//
//  Array+KIS.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 07.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension Array {
    public func safeRef (_ index: Int) -> Element? {
        return 0 <= index && index < count ? self[index] : nil
    }

    public func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
