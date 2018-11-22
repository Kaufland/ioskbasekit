//
//  RestClient+ExecuteRequest.swift
//  KRestKit
//
//  Created by Markus Troßbach on 13/04/2017.
//  Copyright © 2017 Markus Troßbach. All rights reserved.
//

import Foundation

extension RestClient {
    // swiftlint:disable function_body_length
    internal func executeRequest<T: Request>(_ httpRequest: T, urlRequest: URLRequest, completion: @escaping (HTTPResult<T>) -> Void) {

        var startTime = Date()
        self.logV("\(urlRequest.httpMethod ?? "?") \(urlRequest.url?.absoluteString ?? "") (ETag: \(httpRequest.etag ?? "none")) started ...")
        let task = self.urlSession.dataTask(with: urlRequest) { (data, response, urlError) in
            GlobalActivityIndicator.shared.hide(reference: self.logTag)
            if let error = self.convertError(error: urlError) {
                return completion(.exception(error, nil))

            } else if let response = response as? HTTPURLResponse {
                var isCached = false
                var responseEtag: String?
                var responseRequestId: String?

                if response.statusCode == 304 {
                    isCached = true
                    responseEtag = httpRequest.etag
                }

                let lowercasedHeaders = response.lowercasedHeaders()

                lowercasedHeaders.forEach { (key, value) in
                    if key == "etag" {
                        responseEtag = value as? String
                    } else if key == "x-request-id" {
                        responseRequestId = value as? String
                    }
                }

                var responseStruct = Response(statusCode: response.statusCode,
                                              headers: response.allHeaderFields as? [String: String] ?? [:],
                                              contentType: lowercasedHeaders["content-type"] as? String,
                                              contentLength: lowercasedHeaders["content-length"] as? String,
                                              isCachedResponse: isCached,
                                              etag: responseEtag,
                                              request: httpRequest,
                                              requestDuration: -startTime.timeIntervalSinceNow,
                                              parsingDuration: 0,
                                              requestId: responseRequestId)

                startTime = Date()
                let httpMehodString = urlRequest.httpMethod.safeVal
                let urlString = (urlRequest.url?.absoluteString).safeVal
                // swiftlint:disable line_length
                self.logV("\(httpMehodString) \(urlString) finished with HTTP \(response.statusCode) after \(responseStruct.requestDuration)s with \((data?.count).safeVal) bytes (Content-Length: \(responseStruct.contentLength.safeVal)) (ETag: \(responseEtag ?? "none")) \(isCached ? "- cached response" : "- not cached response")")
                // swiftlint:enable line_length

                if response.statusCode >= 500 {
                    // swiftlint:disable line_length
                    Log.recordNonFatal(domain: "HTTPError", code: response.statusCode, customAttributes: ["url": (urlRequest.url?.absoluteString ?? "") as AnyObject, "method": (urlRequest.httpMethod ?? "") as AnyObject, "requestId": (responseRequestId ?? "") as AnyObject])
                    // swiftlint:enable line_length
                }

                switch httpRequest.classificationForStatusCode(statusCode: response.statusCode) {
                case .ok:
                    do {
                        let decodedResponse = try httpRequest.decodeResponse(data: data, statusCode: response.statusCode)
                        responseStruct.parsingDuration = -startTime.timeIntervalSinceNow
                        self.logV("\(urlRequest.httpMethod.safeVal) \((urlRequest.url?.absoluteString).safeVal) parsed after \(responseStruct.parsingDuration)s")
                        return completion(HTTPResult<T>.success(decodedResponse, responseStruct))
                    } catch {
                        // swiftlint:disable line_length
                        Log.recordNonFatal(domain: "ParsingError", code: 1, customAttributes: ["url": (urlRequest.url?.absoluteString ?? "") as AnyObject, "method": (urlRequest.httpMethod ?? "") as AnyObject, "requestId": (responseRequestId ?? "") as AnyObject])
                        // swiftlint:enable line_length
                        return completion(HTTPResult<T>.exception(.parsing(error), responseStruct))
                    }

                case .error:
                    do {
                        let decodedResponse = try httpRequest.decodeErrorResponse(data: data, statusCode: response.statusCode)
                        responseStruct.parsingDuration = -startTime.timeIntervalSinceNow
                        self.logV("\(urlRequest.httpMethod.safeVal) \((urlRequest.url?.absoluteString).safeVal) error parsed after \(responseStruct.parsingDuration)s")
                        return completion(HTTPResult<T>.error(decodedResponse, responseStruct))
                    } catch {
                        // swiftlint:disable line_length
                        Log.recordNonFatal(domain: "ParsingError", code: 1, customAttributes: ["url": (urlRequest.url?.absoluteString ?? "") as AnyObject, "method": (urlRequest.httpMethod ?? "") as AnyObject, "requestId": (responseRequestId ?? "") as AnyObject])
                        // swiftlint:enable line_length
                        return completion(HTTPResult<T>.exception(.parsing(error), responseStruct))
                    }
                case .determinableWithResponse:
                    let decodedResponse = try? httpRequest.decodeResponse(data: data, statusCode: response.statusCode)
                    let decodedErrorResponse = try? httpRequest.decodeErrorResponse(data: data, statusCode: response.statusCode)

                    responseStruct.parsingDuration = -startTime.timeIntervalSinceNow
                    let isError = httpRequest.isErrorResponse(object: decodedResponse ?? nil, errorObject: decodedErrorResponse)
                    self.logV("\(urlRequest.httpMethod.safeVal) \((urlRequest.url?.absoluteString).safeVal) status determinable with response, error = \(isError)")

                    if let decodedErrorResponse = decodedErrorResponse, isError {
                        self.logV("\(urlRequest.httpMethod.safeVal) \((urlRequest.url?.absoluteString).safeVal) parsed after \(responseStruct.parsingDuration)s")
                        return completion(HTTPResult<T>.error(decodedErrorResponse, responseStruct))
                    } else if let decodedResponse = decodedResponse, !isError {
                        self.logV("\(urlRequest.httpMethod.safeVal) \((urlRequest.url?.absoluteString).safeVal) error parsed after \(responseStruct.parsingDuration)s")
                        return completion(HTTPResult<T>.success(decodedResponse, responseStruct))
                    } else {
                        // swiftlint:disable line_length
                        Log.recordNonFatal(domain: "ParsingError", code: 1, customAttributes: ["url": (urlRequest.url?.absoluteString ?? "") as AnyObject, "method": (urlRequest.httpMethod ?? "") as AnyObject, "requestId": (responseRequestId ?? "") as AnyObject])
                        // swiftlint:enable line_length
                        return completion(HTTPResult<T>.exception(.parsing(nil), responseStruct))
                    }
                }

            } else {
                return completion(.exception(KNetworkError.noResponse, nil))
            }

        }
        task.resume()
        GlobalActivityIndicator.shared.show(reference: self.logTag)
    }
    // swiftlint:enable function_body_length
}
