//
//  MeterResult.swift
//  
//
//  Created by Paulo Fierro on 27/06/2021.
//

import Foundation

struct MeterResult: Decodable {
    let meterId: String
    let channel: String
    let outputUnit: String
}
