//
//  MainWeather.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

struct MainWeather: Decodable {
    var temp: Double
    var feelsLike: Double
    var minTemp: Double
    var maxTemp: Decimal
    var pressure: Int
    var humidity: Int8
    var seaLevel: Int?
    var groundLevel: Int?

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case minTemp = "tempMin"
        case maxTemp = "tempMax"
        case pressure
        case humidity
        case seaLevel
        case groundLevel = "grndLevel"
    }
}
