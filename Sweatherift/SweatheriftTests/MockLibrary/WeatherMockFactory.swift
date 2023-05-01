//
//  WeatherMockFactory.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation
@testable import Sweatherift

struct WeatherMockFactory {
   static func makeWeatherReportByLatLon(lat _: Decimal? = nil, lon _: Decimal? = nil) -> WeatherReport {
      let result = Bundle.main.decodeJSONResource("WeatherByLatLon", returnType: WeatherReport.self)
      switch result {
         case let .success(success):
            return success
         case let .failure(failure):
            fatalError("\(failure)")
      }
   }

   static func makeLocations(searchTerm _: String) -> [Location] {
      let result = Bundle.main.decodeJSONResource("GeoByLocationName", returnType: [Location].self)
      switch result {
         case let .success(success):
            return success
         case let .failure(failure):
            fatalError("\(failure)")
      }
   }
}
