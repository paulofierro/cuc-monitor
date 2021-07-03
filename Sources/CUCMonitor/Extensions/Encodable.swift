//
//  Encodable.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

extension Encodable {
    /// Convert the data to JSON
    func toJSON() throws -> String {
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
}

extension EncodingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noData:
            return "Encoded JSON is nil"
        }
    }
}
