//
//  HTTPHeaders.swift
//  KRestKit
//
//  Created by Markus Troßbach on 11/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension HTTPURLResponse {

    func lowercasedHeaders() -> [String: Any] {
        let currentHeaders = allHeaderFields
        var lowercasedHeaders = [String: Any]()

        for (key, value) in currentHeaders {
            if let key = key as? String {
                lowercasedHeaders[key.lowercased()] = value
            }
        }

        return lowercasedHeaders
    }

}
