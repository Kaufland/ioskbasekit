//
//  MulticastDelegate.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 13.06.17.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

private class WeakWrapper {
    weak var value: AnyObject?

    init(value: AnyObject) {
        self.value = value
    }
}

public class MulticastDelegate<T> {
    private var weakDelegates = [WeakWrapper]()
    public var delegatesChanged: ((MulticastDelegate<T>, T?) -> Void)?
    public var count: Int {
        return weakDelegates.count
    }

    public init() {

    }

    public func add(delegate: T) {
        weakDelegates.append(WeakWrapper(value: delegate as AnyObject))
        delegatesChanged?(self, delegate)
    }

    public func remove(delegate: T) {
        for (index, delegateInArray) in weakDelegates.enumerated().reversed() {
            if delegateInArray.value === (delegate as AnyObject) {
                weakDelegates.remove(at: index)
                delegatesChanged?(self, nil)
            }
        }
    }

    public func invoke(_ invocation: (T) -> Void) {
        for (index, delegate) in weakDelegates.enumerated().reversed() {
            if let delegate = delegate.value {
                // swiftlint:disable force_cast
                invocation(delegate as! T)
                // swiftlint:enable force_cast
            } else {
                weakDelegates.remove(at: index)
            }
        }
    }

    public func invokeOnMain(_ invocation: @escaping (T) -> Void) {
        DispatchQueue.assureDispatchOnMain { [weak self] in
            self?.invoke(invocation)
        }
    }
}
