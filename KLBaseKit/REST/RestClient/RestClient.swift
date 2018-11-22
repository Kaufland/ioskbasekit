//
//  APIClient.swift
//  KAppKit
//
//  Created by Markus Troßbach on 12/09/16.
//  Copyright © 2016 Markus Troßbach. All rights reserved.
//

import Foundation

public class RestClient: Logging {

    private let operationQueue = OperationQueue()
    private(set) public var baseUrl: String
    let certificates: [SSLCertificate]?

    public weak var authenticationDelegate: RestClientAuthenticationDelegate?

    public var maxConcurrentRequests: Int {
        get {
            return operationQueue.maxConcurrentOperationCount
        }
        set(value) {
            operationQueue.maxConcurrentOperationCount = value
        }
    }

    public init(baseUrl: String, pinCertificates: [SSLCertificate]? = nil, sessionConfiguration: URLSessionConfiguration? = nil) {
        self.baseUrl = baseUrl
        self.certificates = pinCertificates

        if let sessionConfiguration = sessionConfiguration {
            self.sessionConfiguration = sessionConfiguration
        } else {
            let config = URLSessionConfiguration.default
            config.httpShouldUsePipelining = true
            config.requestCachePolicy = .reloadIgnoringLocalCacheData
            self.sessionConfiguration = config
        }
    }

    private var sessionConfiguration: URLSessionConfiguration!

    lazy internal var urlSession: URLSession = {
        if let certificates = self.certificates, certificates.count > 0 {
            return URLSession(configuration: self.sessionConfiguration,
                              delegate: URLSessionPinningDelegate(pinCertificates: certificates),
                                    delegateQueue: nil)
        } else {
            return URLSession(configuration: self.sessionConfiguration)
        }
    }()

    public func performRequest<T: Request>(_ httpRequest: T, completion: @escaping (HTTPResult<T>) -> Void) {
        self.operationQueue.addOperation {
            self.prepareRequestAuthenticationInformation(httpRequest) { (error, authHeaders, authQueryParams) in
                if let error = error {
                    return completion(HTTPResult<T>.exception(error, nil))
                } else {
                    self.prepareRequest(httpRequest, authHeaders: authHeaders, authParameters: authQueryParams) { (error, urlRequest) in
                        if let error = error {
                            return completion(HTTPResult<T>.exception(error, nil))
                        } else {
                            guard let urlRequest = urlRequest else {
                                return completion(HTTPResult<T>.exception(.invalidRequest, nil))
                            }
                            return self.executeRequest(httpRequest, urlRequest: urlRequest, completion: completion)
                        }
                    }
                }
            }
        }
    }
}
