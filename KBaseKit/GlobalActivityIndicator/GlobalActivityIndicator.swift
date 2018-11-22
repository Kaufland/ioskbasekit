//
//  GlobalActivityIndicator.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 26.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol GlobalActivityIndicatorDelegate: class {
    func globalActivityIndicatorChangedState(show: Bool)
}

public class GlobalActivityIndicator {
    public static let shared = GlobalActivityIndicator()
    public let delegates = MulticastDelegate<GlobalActivityIndicatorDelegate>()

    private var list = Set<Int>()
    private(set) public var currentlyVisible: Bool = false

    private init() {
        delegates.delegatesChanged = { [weak self] delegates, delegate in
            if let this = self {
                delegate?.globalActivityIndicatorChangedState(show: this.currentlyVisible)
            }
        }
    }

    public func show<T: Hashable>(reference: T) {
        DispatchQueue.assureDispatchOnMain {
            self.list.insert(reference.hashValue)
            self.reevaluateDisplay()
        }
    }

    public func hide<T: Hashable>(reference: T) {
        DispatchQueue.assureDispatchOnMain {
            self.list.remove(reference.hashValue)
            self.reevaluateDisplay()
        }
    }

    private func reevaluateDisplay() {
        DispatchQueue.assureDispatchOnMain {
            self.currentlyVisible = self.list.count > 0
            self.delegates.invoke { [weak self] delegate in
                if let this = self {
                    delegate.globalActivityIndicatorChangedState(show: this.currentlyVisible)
                }
            }
        }
    }

}
