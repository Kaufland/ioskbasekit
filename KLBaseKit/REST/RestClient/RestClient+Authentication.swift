//
//  RestClient+Authentication.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension RestClient {
    internal func prepareRequestAuthenticationInformation<T: Request>(
        _ httpRequest: T,
        completion: @escaping (KNetworkError?, AuthenticationHeaders?, AuthenticationQueryParameters?) -> Void) {

        switch httpRequest.authentication {
        case .none:
            return completion(nil, nil, nil)
        case .custom(let authIdentifier):
            guard let delegate = authenticationDelegate else {
                return completion(.authenticationMissing, nil, nil)
            }

            delegate.generateAuthenticationInformation(httpRequest, identifier: authIdentifier) { ( headers, parameters) in
                completion(nil, headers, parameters)
            }
        }
    }
}
