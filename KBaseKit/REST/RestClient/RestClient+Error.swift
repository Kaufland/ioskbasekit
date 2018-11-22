//
//  RestClient+Error.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension RestClient {

    internal func convertError(error: Error?) -> KNetworkError? {
        if let error = error {
            return KNetworkError.convert(error)
        }
        return nil
    }

}
