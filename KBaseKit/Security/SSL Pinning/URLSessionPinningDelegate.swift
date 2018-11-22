//
//  URLSessionPinningDelegate.swift
//  KSecKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public class URLSessionPinningDelegate: NSObject, URLSessionDelegate {

    private(set) public var certs = NSMutableArray()

    public init(pinCertificates: [SSLCertificate]) {
        super.init()
        pinCertificates.forEach { cert in
            self.certs.add(cert.certificate)
        }
    }

    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {

        if let serverTrust = challenge.protectionSpace.serverTrust, challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {

            SecTrustSetAnchorCertificates(serverTrust, certs)
            SecTrustSetAnchorCertificatesOnly(serverTrust, true)

            var trustResult = SecTrustResultType.invalid
            SecTrustEvaluate(serverTrust, &trustResult)
            let trusted = trustResult == SecTrustResultType.unspecified

            if trusted {
                completionHandler(.useCredential, URLCredential(trust: serverTrust))
            } else {
                completionHandler(.cancelAuthenticationChallenge, nil)
            }
        }

    }
}
