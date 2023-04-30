//
//  WeatherReport.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

struct WeatherReport: Decodable, Identifiable {
   let id: Int
   var coOrdinates: CoOrdinates
   let weather: [Weather]
   let base: String
   let main: MainWeather
   let visibility: Int
   let wind: Wind
   let clouds: Clouds
   let dateInt: Int
   let system: System
   let timezone: Int
   let name: String
   let cod: Int

   enum CodingKeys: String, CodingKey {
      case id
      case coOrdinates = "coord"
      case weather
      case base
      case main
      case visibility
      case wind
      case clouds
      case dateInt = "dt"
      case system = "sys"
      case timezone
      case name
      case cod
   }
}
