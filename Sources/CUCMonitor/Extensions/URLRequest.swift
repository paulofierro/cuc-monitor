//
//  URLRequest.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

typealias Parameters = [String: Any]

extension URLRequest {
    
    /// Returns a POST request
    static func postRequest(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0, data: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        if let data = data {
            request.httpBody = data
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    /// Add URL parameters to a request. Also adds required HTTP headers if these are missing
    mutating func addURLParameters(_ parameters: Parameters) {
        guard let url = url else {
            return
        }

        if parameters.isNotEmpty {
            // Add a query item for each param
            var items = [URLQueryItem]()
            parameters
                .sorted(by: {
                    $0.key < $1.key
                })
                .forEach { key, value in
                    let encodedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                    let item = URLQueryItem(name: key, value: encodedValue)
                    items.append(item)
                }

            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = items

            // Finally replace our URL
            self.url = components?.url
        }
    }
}
