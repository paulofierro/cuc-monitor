//
//  UsageDataRequest.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

struct UsageDataRequest {
    
    let meterId: String
    
    init(meterId: String) {
        self.meterId = meterId
    }
    
    func toData() -> Data? {
        let bodyObject: [String : Any] = [
            "rollup": "Day",
            "startDtm": "2021-05-24 00:00:00", // TODO: Calculate this
            "endDtm": "2021-06-24 00:00:00",  // TODO: Calculate this
            "channel": "KWh",
            "forceInitialCommodityTp": "E",
            "meterId": "\(meterId)",
            "showCostBar": false,
            "inputParameters": [
                [
                    "paramId": "DatasetType",
                    "enumValues": [
                        "None",
                        "Weather",
                        "Register",
                        "Average"
                    ],
                    "isRequired": true,
                    "defaultValue": "None",
                    "type": "Enumeration",
                    "value": "Weather"
                ],
                [
                    "isRequired": false,
                    "defaultValue": "CUC",
                    "paramId": "WeatherStation",
                    "label": "Weather Station",
                    "type": "Enumeration",
                    "enumValues": [
                        "CUC"
                    ],
                    "value": "CUC"
                ],
                [
                    "isRequired": true,
                    "defaultValue": "Temperature",
                    "paramId": "WeatherDataType",
                    "label": "Weather Data Type",
                    "type": "Enumeration",
                    "enumValues": [
                        "Temperature",
                        "Relative Humidity",
                        "Daily Precipitation",
                        "Wind Speed"
                    ],
                    "value": "Temperature"
                ],
                [
                    "paramId": "WeatherDataUOM",
                    "enumValues": [
                        "F",
                        "C"
                    ],
                    "isRequired": true,
                    "defaultValue": "C",
                    "type": "Enumeration",
                    "value": "C"
                ]
            ],
            "uom": "KWh"
        ]
        
        do {
            return try JSONSerialization.data(withJSONObject: bodyObject, options: [])
        }
        catch {
            log.error("Could not serialize JSON: \(error.localizedDescription)")
        }
        return nil
    }
}
