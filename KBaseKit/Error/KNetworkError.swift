//
//  KError.swift
//  KCoreKit
//
//  Created by Markus Troßbach on 14.02.18.
//  Copyright © 2018 Markus Troßbach. All rights reserved.
//

import Foundation

public enum KNetworkError: Error {
    case noInternet
    case callIsActive
    case dnsLookupFailed
    case badUrl
    case internationalRoamingOff
    case dataNotAllowed
    case timedOut
    case userCancelled
    case connectionAbort
    case serverCertificateUntrusted
    case connectionLost
    case invalidRequest
    case authenticationMissing
    case noResponse
    case parsing(Error?)
    case generic(Error?)

    public static func convert(_ error: Error?) -> KNetworkError {
        if let error = error {
            switch error {
            case URLError.timedOut:
                return .timedOut
            case URLError.notConnectedToInternet:
                return .noInternet
            case URLError.callIsActive:
                return .callIsActive
            case URLError.internationalRoamingOff:
                return .internationalRoamingOff
            case URLError.dataNotAllowed:
                return .dataNotAllowed
            case URLError.cancelled:
                return .userCancelled
            case URLError.badURL:
                return .badUrl
            case URLError.dnsLookupFailed, URLError.cannotFindHost:
                return .dnsLookupFailed
            case URLError.networkConnectionLost:
                return .connectionLost
            case URLError.serverCertificateHasBadDate, URLError.serverCertificateUntrusted, URLError.serverCertificateNotYetValid, URLError.serverCertificateHasUnknownRoot:
                return .serverCertificateUntrusted
            case POSIXError.ECONNABORTED:
                return .connectionAbort
            default:
                return .generic(error)
            }
        }
        return .generic(error)
    }
}
