//
//  WeatherRepository.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

enum WeatherCacheKey: Hashable {
   case weatherByLatLon(lat: Double, lon: Double)
   case locationByLatLon(lat: Double, lon: Double)
   case locations(searchTerm: String)
}

class WeatherRepository: WeatherRepositoryProtocol {
   
   // MARK: - Properties

   @Injected(\.weatherAPIService) var weatherAPIService
   private var cache: Cache<WeatherCacheKey, Any> = .init()

   // MARK: - Implemented Methods

   func getWeatherByLatLon(lat: Double, lon: Double, useCache: Bool) async -> Result<WeatherReport, Error> {
      let result = await cache.getCacheOrResult(useCache: useCache,
                                                forKey: .weatherByLatLon(lat: lat, lon: lon),
                                                returnType: WeatherReport.self)
      {
         let subResult = await self.weatherAPIService.getWeatherByLatLon(lat: lat, lon: lon)
         if case let .success(success) = subResult {
            self.cache.insert(success,
                              forKey: .weatherByLatLon(lat: lat, lon: lon),
                              expirationDate: Date.now.addingTimeInterval(15 * 60))
         }
         return subResult
      }
      return result
   }

   func getLocationByLatLon(lat: Double, lon: Double, useCache: Bool) async -> Result<Location, Error> {
      let result = await cache.getCacheOrResult(useCache: useCache,
                                                forKey: .locationByLatLon(lat: lat, lon: lon),
                                                returnType: Location.self)
      {
         let subResult = await self.weatherAPIService.getLocationByLatLon(lat: lat, lon: lon)
         if case let .success(success) = subResult {
            self.cache.insert(success,
                              forKey: .locationByLatLon(lat: lat, lon: lon),
                              expirationDate: Date.now.addingTimeInterval(.infinity))
         }
         return subResult
      }
      return result
   }

   func searchLocations(searchTerm: String, useCache: Bool) async -> Result<[Location], Error> {
      let result = await cache.getCacheOrResult(useCache: useCache,
                                                forKey: .locations(searchTerm: searchTerm),
                                                returnType: [Location].self)
      {
         let subResult = await self.weatherAPIService.searchLocations(searchTerm: searchTerm)
         if case let .success(success) = subResult {
            self.cache.insert(success,
                              forKey: .locations(searchTerm: searchTerm),
                              expirationDate: Date.now.addingTimeInterval(.infinity))
         }
         return subResult
      }
      return result
   }
   
   func clearAll() {
      //
   }
}
