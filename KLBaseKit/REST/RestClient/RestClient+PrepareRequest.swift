//
//  RestClient+PrepareRequest.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension RestClient {
    // swiftlint:disable cyclomatic_complexity
    internal func prepareRequest<T: Request>(
        _ httpRequest: T,
        authHeaders: AuthenticationHeaders?,
        authParameters: AuthenticationQueryParameters?,
        completion: @escaping (KNetworkError?, URLRequest?) -> Void) {

        var urlString = httpRequest.path
        if !urlString.contains("://") {
            if baseUrl.hasSuffix("/") || urlString.hasPrefix("/") {
                urlString = baseUrl + urlString
            } else {
                urlString = baseUrl + "/" + urlString
            }
        }

        guard let url = URL(string: urlString), var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return completion(.badUrl, nil)
        }

        var header: [String: String] = httpRequest.header

        if httpRequest.accept.count > 0 {
            header["Accept"] = httpRequest.accept
        }

        if httpRequest.contentType.count > 0 {
            header["Content-Type"] = httpRequest.contentType
        }

        if let etag = httpRequest.etag {
            header["If-None-Match"] = etag
        }

        if let authHeaders = authHeaders {
            for (key, value) in authHeaders {
                header[key] = value
            }
        }

        var queryItems = [URLQueryItem]()

        components.queryItems?.forEach { item in
            queryItems.append(item)
        }

        httpRequest.query.forEach { (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        authParameters?.forEach { (key, value) in
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        if queryItems.count > 0 {
            components.queryItems = queryItems
        }

        guard let resultURL = components.url else {
            return completion(.badUrl, nil)
        }

        var request = URLRequest(url: resultURL)
        request.httpMethod = httpRequest.method.rawValue.uppercased()
        header.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        request.httpBody = httpRequest.generateBody()

        request.cachePolicy = httpRequest.cachePolicy
        if let _ = httpRequest.etag {
            request.cachePolicy = .reloadIgnoringLocalCacheData
        }

        completion(nil, request)
    }
    // swiftlint:enable cyclomatic_complexity
}
