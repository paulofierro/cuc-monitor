//
//  URLRequest.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

extension URLRequest {
    
    /// Returns a POST request
    static func postRequest(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        return request
    }
}
