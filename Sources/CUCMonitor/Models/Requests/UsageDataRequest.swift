//
//  UsageDataRequest.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

struct UsageDataRequest: Encodable {
    let rollup = "Day"
    let startDate = "2021-05-24 00:00:00" // TODO Pass this in
    let endDate = "2021-06-24 00:00:00"   // TODO Pass this in
    let channel = "KWh"
    let intialCommodityType = "E"
    let showCostBar = false
    let uom = "KWh"
    let inputParameters: [InputParameter]
    let meterId: String

    enum CodingKeys: String, CodingKey {
        case rollup, channel, meterId, showCostBar, uom, inputParameters
        case startDate = "startDtm"
        case endDate = "endDtm"
        case intialCommodityType = "forceInitialCommodityTp"
    }

    init(meterId: String) {
        self.meterId = meterId
        self.inputParameters = [
            InputParameter(
                paramId: "DatasetType",
                isRequired: true,
                defaultValue: "None",
                value: "Weather",
                label: nil
            ),
            InputParameter(
                paramId: "WeatherStation",
                isRequired: false,
                defaultValue: "CUC",
                value: "CUC",
                label: "Weather Station"
            ),
            InputParameter(
                paramId: "WeatherDataType",
                isRequired: true,
                defaultValue: "Temperature",
                value: "Temperature",
                label: "Weather Data Type"
            ),
            InputParameter(
                paramId: "WeatherDataUOM",
                isRequired: true,
                defaultValue: "C",
                value: "C",
                label: nil
            )
        ]
    }

    struct InputParameter: Encodable {
        let paramId: String
        let isRequired: Bool
        let defaultValue: String
        let type = "Enumeration"
        let value: String
        let label: String?
    }
}
