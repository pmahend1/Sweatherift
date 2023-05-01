//
//  WeatherAPIService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

class WeatherAPIService: WeatherAPIProtocol {
   // MARK: - Properties

   @Injected(\.RESTService) var RESTService

   func getWeatherByLatLon(lat: Double, lon: Double) async -> Result<WeatherReport, Error> {
      let url = "\(Constants.weatherURL)lat=\(lat)&lon=\(lon)&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService.get(url: url, returnType: WeatherReport.self)
      return result
   }

   func getLocationByLatLon(lat: Double, lon: Double) async -> Result<Location, Error> {
      let reverseGeoURL = Constants.locationLatLonURL(lat: lat, lon: lon)
      let locationResult = await RESTService.get(url: reverseGeoURL, returnType: [Location].self)
      switch locationResult {
         case let .success(success):
            if success.count > 0 {
               return .success(success[0])
            } else {
               return .failure(APIError(message: "Empty"))
            }

         case let .failure(failure):
            return .failure(failure)
      }
   }

   func searchLocations(searchTerm: String) async -> Result<[Location], Error> {
      let url = "\(Constants.locationNameURL)\(searchTerm)&limit=5&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService.get(url: url, returnType: [Location].self)
      return result
   }
}
