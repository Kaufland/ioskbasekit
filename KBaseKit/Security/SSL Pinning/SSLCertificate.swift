//
//  SSLCertificate.swift
//  KSecKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public struct SSLCertificate {
    public let certificate: SecCertificate
    public init(certificate: SecCertificate) {
        self.certificate = certificate
    }
}
