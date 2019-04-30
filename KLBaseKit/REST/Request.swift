//
//  Request.swift
//  KAppKit
//
//  Created by Markus Troßbach on 23/11/16.
//  Copyright © 2016 Markus Troßbach. All rights reserved.
//

import Foundation

public enum RestMethod: String {
    case get
    case post
    case delete
    case put
    case patch
    case head
    case options
    case trace
    case connect
}

public enum RestAuthentication {
    case none
    case custom(String?)
}

// swiftlint:disable identifier_name
public enum ResponseClassification {
    case ok
    case error
    case determinableWithResponse
}
// swiftlint:enable identifier_name

public protocol Request {
    associatedtype ResponseObject: Any
    associatedtype ErrorResponseObject: Any

    var method: RestMethod { get }
    var authentication: RestAuthentication { get }
    var header: [String: String] { get }
    var query: [String: String] { get }
    var path: String { get }
    var accept: String { get }
    var contentType: String { get }
    var cachePolicy: NSURLRequest.CachePolicy { get }
    var etag: String? { get }

    func generateBody() -> Data?
    func decodeResponse(data: Data?, statusCode: Int) throws -> ResponseObject?
    func decodeErrorResponse(data: Data?, statusCode: Int) throws -> ErrorResponseObject

    func classificationForStatusCode(statusCode: Int) -> ResponseClassification
    func isErrorResponse(object: ResponseObject?, errorObject: ErrorResponseObject?) -> Bool
}

public extension Request {
    var cachePolicy: NSURLRequest.CachePolicy {
        return .useProtocolCachePolicy
    }

    var authentication: RestAuthentication {
        return .none
    }

    var header: [String: String] {
        return [:]
    }

    var query: [String: String] {
        return [:]
    }

    var accept: String {
        return "application/json;charset=utf-8"
    }

    var contentType: String {
        return "application/json;charset=utf-8"
    }

    var etag: String? {
        return nil
    }

    func generateBody() -> Data? {
        return nil
    }

    func classificationForStatusCode(statusCode: Int) -> ResponseClassification {
        if statusCode < 400 {
            return .ok
        }
        return .error
    }

    func isErrorResponse(object: ResponseObject?, errorObject: ErrorResponseObject?) -> Bool {
        return false
    }
}

public extension Request where ResponseObject == NSDictionary {
    func decodeResponse(data: Data?, statusCode: Int) throws -> NSDictionary {
        do {
            if let data = data, let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSDictionary {
                return dict
            }
            throw KNetworkError.parsing(nil)
        } catch {
            throw KNetworkError.parsing(error)
        }
    }
}

public extension Request where ResponseObject == NSArray {
    func decodeResponse(data: Data?, statusCode: Int) throws -> NSArray {
        do {
            if let data = data, let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSArray {
                return dict
            }
            throw KNetworkError.parsing(nil)
        } catch {
            throw KNetworkError.parsing(error)
        }
    }
}

public extension Request where ResponseObject == String {
    func decodeResponse(data: Data?, statusCode: Int) throws -> String {
        if let data = data, let string = data.utf8String() {
            return string
        }
        throw KNetworkError.parsing(nil)
    }
}

public extension Request where ErrorResponseObject == NSDictionary {
    func decodeErrorResponse(data: Data?, statusCode: Int) throws -> NSDictionary {
        do {
            if let data = data, let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSDictionary {
                return dict
            }
            throw KNetworkError.parsing(nil)
        } catch {
            throw KNetworkError.parsing(error)
        }
    }
}

public extension Request where ErrorResponseObject == NSArray {
    func decodeErrorResponse(data: Data?, statusCode: Int) throws -> NSArray {
        do {
            if let data = data, let dict = try JSONSerialization.jsonObject(with: data, options: [.allowFragments]) as? NSArray {
                return dict
            }
            throw KNetworkError.parsing(nil)
        } catch {
            throw KNetworkError.parsing(error)
        }
    }
}

public extension Request where ErrorResponseObject == String {
    func decodeErrorResponse(data: Data?, statusCode: Int) throws -> String {
        if let data = data, let string = data.utf8String() {
            return string
        }
        throw KNetworkError.parsing(nil)
    }
}
