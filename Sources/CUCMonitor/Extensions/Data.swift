//
//  Data.swift
//  
//
//  Created by Paulo Fierro on 03/07/2021.
//

import Foundation

extension Data {

    // Loads a JSON file from a bundle
    static func loadJSON(from filename: String, bundle: Bundle? = nil) throws -> Data? {
        guard let path = bundle?.path(forResource: filename, ofType: "json") else {
            log.error("File not found: \(filename).json")
            return nil
        }
        let contents = try? String(contentsOfFile: path)
        return contents?.data(using: .utf8)
    }
}
