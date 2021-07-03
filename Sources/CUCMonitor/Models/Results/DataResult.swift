//
//  DataResult.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

struct DataResult: Decodable {
    let meterId: String
}
// {
//  "meterId": "",
//  "rollup": "Day",
//  "channel": "KWh",
//  "uom": "KWh",
//  "inputParameters": [
//    {
//      "type": "Enumeration",
//      "paramId": "DatasetType",
//      "isRequired": true,
//      "enumValues": [
//        "None",
//        "Weather",
//        "Register",
//        "Average"
//      ],
//      "defaultValue": "None",
//      "value": "Weather"
//    },
//    {
//      "type": "Enumeration",
//      "paramId": "WeatherStation",
//      "label": "Weather Station",
//      "isRequired": false,
//      "enumValues": [
//        "CUC"
//      ],
//      "defaultValue": "CUC",
//      "value": "CUC"
//    },
//    {
//      "type": "Enumeration",
//      "paramId": "WeatherDataType",
//      "label": "Weather Data Type",
//      "isRequired": true,
//      "enumValues": [
//        "Temperature",
//        "Relative Humidity",
//        "Daily Precipitation",
//        "Wind Speed"
//      ],
//      "defaultValue": "Temperature",
//      "value": "Temperature"
//    },
//    {
//      "type": "Enumeration",
//      "paramId": "WeatherDataUOM",
//      "isRequired": true,
//      "enumValues": [
//        "F",
//        "C"
//      ],
//      "defaultValue": "C",
//      "value": "C"
//    }
//  ],
//  "showCostBar": true,
//  "weatherStationName": "CUC",
//  "weatherDataType": "Temperature",
//  "weatherDataUom": "C",
//  "startDtm": "2021-05-24 00:00:00",
//  "endDtm": "2021-06-24 00:00:00",
//  "results": [
//    [
//      [
//        "2021-05-24 00:00",
//        59.494,
//        null
//      ],
//      [
//        "2021-05-25 00:00",
//        83.554,
//        null
//      ],
//      [
//        "2021-05-26 00:00",
//        72.103,
//        null
//      ],
//      [
//        "2021-05-27 00:00",
//        71.673,
//        null
//      ],
//      [
//        "2021-05-28 00:00",
//        67.095,
//        null
//      ],
//      [
//        "2021-05-29 00:00",
//        72.814,
//        null
//      ],
//      [
//        "2021-05-30 00:00",
//        89.621,
//        null
//      ],
//      [
//        "2021-05-31 00:00",
//        102.92,
//        null
//      ],
//      [
//        "2021-06-01 00:00",
//        90.789,
//        null
//      ],
//      [
//        "2021-06-02 00:00",
//        93.732,
//        null
//      ],
//      [
//        "2021-06-03 00:00",
//        112.42,
//        null
//      ],
//      [
//        "2021-06-04 00:00",
//        110.07,
//        null
//      ],
//      [
//        "2021-06-05 00:00",
//        109.05,
//        null
//      ],
//      [
//        "2021-06-06 00:00",
//        112.51,
//        null
//      ],
//      [
//        "2021-06-07 00:00",
//        115.2,
//        null
//      ],
//      [
//        "2021-06-08 00:00",
//        76.914,
//        null
//      ],
//      [
//        "2021-06-09 00:00",
//        66.952,
//        null
//      ],
//      [
//        "2021-06-10 00:00",
//        61.76,
//        null
//      ],
//      [
//        "2021-06-11 00:00",
//        50.415,
//        null
//      ],
//      [
//        "2021-06-12 00:00",
//        51.828,
//        null
//      ],
//      [
//        "2021-06-13 00:00",
//        54.311,
//        null
//      ],
//      [
//        "2021-06-14 00:00",
//        54.323,
//        null
//      ],
//      [
//        "2021-06-15 00:00",
//        65.749,
//        null
//      ],
//      [
//        "2021-06-16 00:00",
//        69.283,
//        null
//      ],
//      [
//        "2021-06-17 00:00",
//        84.131,
//        null
//      ],
//      [
//        "2021-06-18 00:00",
//        78.933,
//        null
//      ],
//      [
//        "2021-06-19 00:00",
//        74.312,
//        null
//      ],
//      [
//        "2021-06-20 00:00",
//        86.648,
//        null
//      ],
//      [
//        "2021-06-21 00:00",
//        85.328,
//        null
//      ],
//      [
//        "2021-06-22 00:00",
//        84.065,
//        null
//      ],
//      [
//        "2021-06-23 00:00",
//        72.898,
//        null
//      ]
//    ]
//  ],
//  "resultsTotals": [
//    [
//      "2021-06-24 00:00",
//      2480.9,
//      null
//    ]
//  ],
//  "resultsWeather": [
//    [
//      "2021-05-24 00:00",
//      27.667,
//      null
//    ],
//    [
//      "2021-05-25 00:00",
//      28.375,
//      null
//    ],
//    [
//      "2021-05-26 00:00",
//      28.042,
//      null
//    ],
//    [
//      "2021-05-27 00:00",
//      27.542,
//      null
//    ],
//    [
//      "2021-05-28 00:00",
//      27.958,
//      null
//    ],
//    [
//      "2021-05-29 00:00",
//      27.625,
//      null
//    ],
//    [
//      "2021-05-30 00:00",
//      28.0,
//      null
//    ],
//    [
//      "2021-05-31 00:00",
//      28.625,
//      null
//    ],
//    [
//      "2021-06-01 00:00",
//      27.542,
//      null
//    ],
//    [
//      "2021-06-02 00:00",
//      27.917,
//      null
//    ],
//    [
//      "2021-06-03 00:00",
//      28.5,
//      null
//    ],
//    [
//      "2021-06-04 00:00",
//      28.625,
//      null
//    ],
//    [
//      "2021-06-05 00:00",
//      28.75,
//      null
//    ],
//    [
//      "2021-06-06 00:00",
//      29.0,
//      null
//    ],
//    [
//      "2021-06-07 00:00",
//      28.25,
//      null
//    ],
//    [
//      "2021-06-08 00:00",
//      28.042,
//      null
//    ],
//    [
//      "2021-06-09 00:00",
//      28.083,
//      null
//    ],
//    [
//      "2021-06-10 00:00",
//      28.417,
//      null
//    ],
//    [
//      "2021-06-11 00:00",
//      28.042,
//      null
//    ],
//    [
//      "2021-06-12 00:00",
//      28.75,
//      null
//    ],
//    [
//      "2021-06-13 00:00",
//      29.167,
//      null
//    ],
//    [
//      "2021-06-14 00:00",
//      29.125,
//      null
//    ],
//    [
//      "2021-06-15 00:00",
//      29.375,
//      null
//    ],
//    [
//      "2021-06-16 00:00",
//      29.208,
//      null
//    ],
//    [
//      "2021-06-17 00:00",
//      29.292,
//      null
//    ],
//    [
//      "2021-06-18 00:00",
//      29.542,
//      null
//    ],
//    [
//      "2021-06-19 00:00",
//      29.583,
//      null
//    ],
//    [
//      "2021-06-20 00:00",
//      29.708,
//      null
//    ],
//    [
//      "2021-06-21 00:00",
//      29.542,
//      null
//    ],
//    [
//      "2021-06-22 00:00",
//      29.5,
//      null
//    ],
//    [
//      "2021-06-23 00:00",
//      29.375,
//      null
//    ]
//  ],
//  "resultsRegister1": [],
//  "resultsRegister2": [],
//  "resultsOtherMeter": [],
//  "resultsAverageRead": [],
//  "resultsInfo": [
//    {
//      "datasetId": "",
//      "datasetTitle": "Usage",
//      "datasetDetail": "MY ST - Meter:  (Electric) Location: 233",
//      "datasetDisplayType": "e"
//    }
//  ],
//  "meterUsageDataList": [
//    {
//      "groupLabel": "Total Usage",
//      "members": [
//        {
//          "total": 2480.9,
//          "detail": {
//            "datasetId": "Total Usage",
//            "datasetTitle": "Total Usage",
//            "datasetRightUOM": "KWh"
//          },
//          "subTotals": [
//            {
//              "detail": {
//                "datasetId": "KWh",
//                "datasetTitle": "Usage",
//                "datasetDisplayType": "usage e",
//                "datasetRightUOM": "KWh"
//              },
//              "value": 2480.9
//            }
//          ],
//          "type": "primary",
//          "startDtm": "2021-05-24 00:00:00",
//          "endDtm": "2021-06-24 00:00:00",
//          "noDataFound": false
//        }
//      ]
//    }
//  ],
//  "meterCostDataList": [
//    {
//      "groupLabel": "Total Cost",
//      "members": [
//        {
//          "total": 636.88,
//          "detail": {
//            "datasetId": "R",
//            "datasetTitle": "R",
//            "datasetLeftUOM": "$"
//          },
//          "subTotals": [
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Energy Charge kWh",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 73.38
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Energy Charge kWh (Effective: 2021-06-01)",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 220.6
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Fuel Cost",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 62.53
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Fuel Cost (Effective: 2021-06-01)",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 216.1
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Govt Fuel Duty",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 8.46
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Govt Fuel Duty (Effective: 2021-06-01)",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 24.84
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Lic and Reg Fees kWh",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 4.39
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Renewable Energy kWh",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 4.86
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Renewable Energy kWh (Effective: 2021-06-01)",
//                "datasetDisplayType": "e tier",
//                "datasetLeftUOM": "$"
//              },
//              "value": 15.9
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Facilities Charge",
//                "datasetDisplayType": "e usage",
//                "datasetLeftUOM": "$"
//              },
//              "value": 1.36
//            },
//            {
//              "detail": {
//                "datasetId": "",
//                "datasetTitle": "Facilities Charge (Effective: 2021-06-01)",
//                "datasetDisplayType": "e usage",
//                "datasetLeftUOM": "$"
//              },
//              "value": 4.46
//            }
//          ],
//          "type": "primary",
//          "startDtm": "2021-05-24 00:00:00",
//          "endDtm": "2021-06-24 00:00:00",
//          "noDataFound": false
//        }
//      ]
//    }
//  ],
//  "oldestReadDtm": "2019-12-26 00:15:00",
//  "forceInitialCommodityTp": "E"
// }
