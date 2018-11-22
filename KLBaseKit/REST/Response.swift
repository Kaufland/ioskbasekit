//
//  Response.swift
//  KAppKit
//
//  Created by Markus Troßbach on 25/11/16.
//  Copyright © 2016 Markus Troßbach. All rights reserved.
//

import Foundation

public enum HTTPResult<T: Request> {
    case success(T.ResponseObject?, Response<T>)
    case error(T.ErrorResponseObject?, Response<T>)
    case exception(KNetworkError, Response<T>?)
}

public struct Response<T: Request> {
    public var statusCode: Int
    public var headers: [String: String]
    public var contentType: String?
    public var contentLength: String?
    public var isCachedResponse: Bool
    public var etag: String?
    public var request: T
    public var requestDuration: TimeInterval
    public var parsingDuration: TimeInterval
    public var requestId: String?
}
