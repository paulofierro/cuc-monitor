//
//  Encodable.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

typealias JSON = [String: Any]

extension Encodable {
    /// Converts to JSON
    func toJSON() -> JSON? {
        let encoder = JSONEncoder()

        guard let data = try? encoder.encode(self),
            let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON else {
            return nil
        }
        return jsonObj
    }

    /// Convert the data to a JSON string
    func toJSONString() throws -> String {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try encoder.encode(self)
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw EncodingError.noData
        }
        return jsonString
    }
}

// MARK: - Encoding Errors

/// Errors that can occur in the JSON encoding process
enum EncodingError: Error {
    case noData
    case encodingFailed
}

extension EncodingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Encoded JSON is nil"
        case .encodingFailed:
            return "Could not encode object."
        }
    }
}
