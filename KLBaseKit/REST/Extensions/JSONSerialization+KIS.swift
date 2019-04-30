//
//  JSONSerialization+KIS.swift
//  KAppKit
//
//  Created by Markus Troßbach on 12/12/2016.
//  Copyright © 2016 Markus Troßbach. All rights reserved.
//

import Foundation

public extension JSONSerialization {
    static func jsonObjects<T: DictionaryDecodable>(type: T.Type, data: Data?) throws -> [T]? {
        guard let data = data else {
            return nil
        }
        if data.count == 0 {
            return nil
        }
        if let object = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]), let array = object as? NSArray {
            var result = [T]()
            result <<? array
            return result
        }
        throw KNetworkError.parsing(nil)
    }

    static func jsonObject<T: DictionaryDecodable>(type: T.Type, data: Data?) throws -> T? {
        guard let data = data else {
            return nil
        }
        if data.count == 0 {
            return nil
        }
        if let object = try? JSONSerialization.jsonObject(with: data, options: [.allowFragments]),
            let dict = object as? [String: Any],
            let dataObject = T.fromDictionary(dictionary: dict) {
            return dataObject
        }
        throw KNetworkError.parsing(nil)
    }
}
