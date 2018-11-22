//
//  RestClientAuthenticationDelegate.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

public protocol RestClientAuthenticationDelegate: class {
    func generateAuthenticationInformation<T: Request>(_ request: T, identifier: String?, completion: @escaping (AuthenticationHeaders?, AuthenticationQueryParameters?) -> Void)
}

public extension RestClientAuthenticationDelegate {
    func createBasicAuthenticationHeader(user: String?, password: String?) -> AuthenticationHeaders {
        guard let user = user, let password = password else {
            return [:]
        }

        if let string = (user+":"+password).data(using: String.Encoding.isoLatin1)?.base64EncodedString() {
            return ["Authorization": "Basic \(string)"]
        } else {
            return [:]
        }
    }
}
