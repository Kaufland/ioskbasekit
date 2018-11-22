//
//  StrongMulticastDelegate.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 14.02.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import Foundation

private class StrongWrapper {
    var value: AnyObject?

    init(value: AnyObject) {
        self.value = value
    }
}

public class StrongMulticastDelegate<T> {
    private var strongDelegates = [StrongWrapper]()
    public var delegatesChanged: ((StrongMulticastDelegate<T>, T?) -> Void)?
    public var count: Int {
        return strongDelegates.count
    }

    public init() {

    }

    public func add(delegate: T) {
        strongDelegates.append(StrongWrapper(value: delegate as AnyObject))
        delegatesChanged?(self, delegate)
    }

    public func remove(delegate: T) {
        for (index, delegateInArray) in strongDelegates.enumerated().reversed() {
            if delegateInArray.value === (delegate as AnyObject) {
                strongDelegates.remove(at: index)
                delegatesChanged?(self, nil)
            }
        }
    }

    public func invoke(_ invocation: (T) -> Void) {
        for delegate in strongDelegates.reversed() {
            // swiftlint:disable force_cast
            invocation(delegate.value as! T)
            // swiftlint:enable force_cast
        }
    }

    public func invokeOnMain(_ invocation: @escaping (T) -> Void) {
        DispatchQueue.assureDispatchOnMain { [weak self] in
            self?.invoke(invocation)
        }
    }
}
