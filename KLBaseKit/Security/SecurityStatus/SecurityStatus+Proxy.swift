//
//  SecurityStatus+Proxy.swift
//  KSecKit
//
//  Created by Markus Troßbach on 19/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public extension SecurityStatus {

    #if os(watchOS)

    #else
    struct Proxy {

        public static var settings: [String: AnyObject]? {
            guard let proxySettingsUnmanaged = CFNetworkCopySystemProxySettings() else {
                return nil
            }
            return proxySettingsUnmanaged.takeRetainedValue() as? [String: AnyObject]
        }

        public static var host: String? {
            return settings?[kCFNetworkProxiesHTTPProxy as String] as? String
        }
        public static var port: Int? {
            return settings?[kCFNetworkProxiesHTTPProxy as String] as? Int
        }

        public static var enabled: Bool {
            if let _ = host, let _ = port {
                return true
            }
            return false
        }
    }
    #endif

}
