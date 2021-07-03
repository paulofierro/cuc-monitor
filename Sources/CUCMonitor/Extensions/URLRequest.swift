//
//  URLRequest.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

typealias Parameters = [String: Any]

extension URLRequest {
    /// Returns a POST request and adds the data to the request body
    static func POST(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0, data: Data? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addUserAgent()

        if let data = data {
            request.httpBody = data
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }

        return request
    }

    /// Returns a GET request and adds the parameters to the query string
    static func GET(url: URL, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeoutInterval: TimeInterval = 60.0, parameters: Parameters? = nil) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addUserAgent()

        if let parameters = parameters {
            request.addURLParameters(parameters)
        }

        return request
    }
}

// MARK: - Helper Functinos

extension URLRequest {
    /// Sets the user agent string
    mutating func addUserAgent() {
        let userAgent = "Mozilla/5.0 (Windows NT 10.0; Trident/7.0; rv:11.0) like Gecko"
        setValue(userAgent, forHTTPHeaderField: "User-Agent")
    }

    /// Add URL parameters to a request
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
