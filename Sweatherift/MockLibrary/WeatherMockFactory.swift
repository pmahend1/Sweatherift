//
//  WeatherMockFactory.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation
@testable import Sweatherift

struct WeatherMockFactory {
   static func makeWeatherReportByLatLon(lat _: Decimal? = nil, lon _: Decimal? = nil) -> Result<WeatherReport, Error> {
      let result = Bundle.main.decodeJSONResource("WeatherByLatLon", returnType: WeatherReport.self)
      return result
   }
   
   static func makeLocations(searchTerm: String)-> Result<[Location], Error> {
      let result = Bundle.main.decodeJSONResource("GeoByLocationName", returnType: [Location].self)
      return result
   }
}
