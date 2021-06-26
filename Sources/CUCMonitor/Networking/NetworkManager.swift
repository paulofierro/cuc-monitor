//
//  NetworkManager.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

class NetworkManager {
    
    private let baseURL = URL(string: "https://cucconnect.cuc.ky/HomeConnect/Controller/")!
    private let loginPath = "Login"
    private let usagePath = "Usage"
    
    private lazy var session: URLSession = {
        URLSession(configuration: URLSessionConfiguration.ephemeral)
    }()
    
    func getData() {
//        login { result in
//            switch result {
//            case .success(let redirectURL):
//                log.debug("Redirect: \(redirectURL)")
//                
//            case .failure(let error):
//                log.error("Error: \(error)")
//            }
//        }
    }
    
    /// Returns the URL to redirect to
    func login(username: String, password: String, completionHandler: @escaping(Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(loginPath)
        
        var request = URLRequest.postRequest(url: url)
        let params = [
            "username": username,
            "password": password,
            "ajax": "true",
        ]
        request.httpBody = params.queryParameters.data(using: .utf8, allowLossyConversion: true)
        
        session.dataTask(
            with: request,
            completionHandler:  { data, response, error in
                if let error = self.checkForErrors(response: response, error: error) {
                    completionHandler(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completionHandler(.failure(NetworkError.noData(-1)))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(LoginResult.self, from: data)
                    completionHandler(.success(result.redirectUrl))
                } catch {
                    completionHandler(.failure(error))
                }
            }
        ).resume()
    }
}

extension NetworkManager {
    
    /// Checks for returned errors and then looks for HTTP error codes.
    private func checkForErrors(response: URLResponse?, error: Error?) -> Error? {
        if let error = error {
            return error
        }

        guard let response = response as? HTTPURLResponse else {
            return NetworkError.invalidResponse
        }
        return response.statusCodeError
    }
}
