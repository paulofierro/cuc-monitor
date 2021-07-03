//
//  DataResult.swift
//  
//
//  Created by Paulo Fierro on 26/06/2021.
//

import Foundation

struct DataResult: Decodable {
    let meterId: String
    let uom: String
    let weatherStationName: String
    let weatherDataType: String
    let temperatureUnit: String
    let startDate: String
    let endDate: String
    let info: [Info]
    private let usageResults: [[[DynamicResult]]]
    private let weatherResults: [[DynamicResult]]
    
    enum CodingKeys: String, CodingKey {
        case meterId, uom, weatherStationName, weatherDataType
        case temperatureUnit = "weatherDataUom"
        case startDate = "startDtm"
        case endDate = "endDtm"
        case info = "resultsInfo"
        case usageResults = "results"
        case weatherResults = "resultsWeather"
    }
    
    // MARK: - Custom Conversion
    
    // Converts the loaded weather results to our strict type
    var weather: [WeatherResult] {
        weatherResults.compactMap {
            if case .string(let dateString) = $0[safeIndex: 0],
                case .double(let temperature) = $0[safeIndex: 1] {
                
                guard let date = DateFormatter.apiResultFormatter.date(from: dateString) else {
                    return nil
                }
                
                return WeatherResult(
                    date: date,
                    temperature: temperature,
                    unit: temperatureUnit
                )
            }
            return nil
        }
    }
    
    // Converts the loaded usage results to our strict type
    var usage: [UsageResult] {
        usageResults
            .reduce([], +)
            .compactMap {
                if case .string(let dateString) = $0[safeIndex: 0],
                   case .double(let usage) = $0[safeIndex: 1] {
                    
                    guard let date = DateFormatter.apiResultFormatter.date(from: dateString) else {
                        return nil
                    }
                    
                    return UsageResult(
                        date: date,
                        usage: usage,
                        unit: uom
                    )
                }
                return nil
            }
    }
    
    struct WeatherResult {
        let date: Date
        let temperature: Double
        let unit: String
    }
    
    struct UsageResult {
        let date: Date
        let usage: Double
        let unit: String
    }
}

// MARK: - Decodable Children

extension DataResult {
    
    struct Info: Decodable {
        let id: String
        let title: String
        let detail: String

        enum CodingKeys: String, CodingKey {
            case id = "datasetId"
            case title = "datasetTitle"
            case detail = "datasetDetail"
        }
    }

    enum DynamicResult: Codable {
        case double(Double)
        case string(String)
        case null

        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let x = try? container.decode(Double.self) {
                self = .double(x)
                return
            }
            if let x = try? container.decode(String.self) {
                self = .string(x)
                return
            }
            if container.decodeNil() {
                self = .null
                return
            }
            
            throw DecodingError.typeMismatch(
                DynamicResult.self,
                DecodingError.Context(
                    codingPath: decoder.codingPath,
                    debugDescription: "Wrong type for DynamicResult"
                )
            )
        }
    }
}
