//
//  NetworkManager.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

final class NetworkManager {
    private let baseURL = URL(string: "https://cucconnect.cuc.ky/HomeConnect")!
    private let loginPath = "Controller/Login"
    private let meterPath = "Controller/GetMyProgressDefaultData"
    private let usagePath = "Controller/Usage"

    private lazy var session: URLSession = {
        URLSession(configuration: .ephemeral)
    }()

    func getData() {
    }

    /// Returns the URL to redirect to
    internal func login(username: String, password: String, completionHandler: @escaping(Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(loginPath)
        var request = URLRequest.POST(url: url)
        let params = [
            "username": username,
            "password": password,
            "ajax": "true"
        ]
        request.httpBody = params.queryParameters.data(using: .utf8, allowLossyConversion: true)

        makeRequest(request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(LoginResult.self, from: data)
                    completionHandler(.success(result.redirectUrl))
                } catch {
                    completionHandler(.failure(error))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    /// Loads the redirect page to finalize the login
    internal func loadRedirect(redirectURL: String, completionHandler: @escaping(Result<Void, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(redirectURL)
        let request = URLRequest.POST(url: url)

        makeRequest(request) { result in
            switch result {
            case .success:
                completionHandler(.success(()))

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    /// Loads the meter ID
    internal func findMeterId(completionHandler: @escaping(Result<String, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(meterPath)
        let request = URLRequest.GET(
            url: url,
            parameters: ["forceInitialCommodityTp": "E"]
        )

        makeRequest(request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(MeterResult.self, from: data)
                    completionHandler(.success(result.meterId))
                } catch {
                    completionHandler(.failure(error))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }

    internal func loadData(meterId: String, completionHandler: @escaping(Result<DataResult, Error>) -> Void) {
        let url = baseURL.appendingPathComponent(usagePath)
        let payload = UsageDataRequest(meterId: meterId).toJSON()
        var request = URLRequest.POST(url: url)
        try? request.addJSONPayload(payload)

        makeRequest(request) { result in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(DataResult.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }

            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}

extension NetworkManager {
    /// Makes a request and returns the loaded data (or the error if there is one)
    private func makeRequest(_ request: URLRequest, completionHandler: @escaping(Result<Data, Error>) -> Void) {
        session.dataTask(
            with: request,
            completionHandler: { data, response, error in
                if let error = self.checkForErrors(response: response, error: error) {
                    completionHandler(.failure(error))
                    return
                }

                guard let data = data else {
                    completionHandler(.failure(NetworkError.noData(-1)))
                    return
                }

                completionHandler(.success(data))
            }
        ).resume()
    }

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
