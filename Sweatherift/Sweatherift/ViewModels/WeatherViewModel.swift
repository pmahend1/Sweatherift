//
//  WeatherViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
   // MARK: - Properties

   @Published var weatherReport: WeatherReport? = nil
   @Published var isBusy = false

   @Injected(\.RESTService) var RESTService
   @Injected(\.analytics) var analytics

   var title: String {
      var stateText = ""
      if let state = location.state {
         stateText = ", \(state)"
      }
      return "\(location.name)\(stateText), \(location.country)"
   }

   private var location: Location

   init(for location: Location) {
      self.location = location
   }

   // MARK: - Methods

   func getWeather() async {
      defer {
         isBusy = false
      }
      isBusy = true
      let url = "\(Constants.weatherUrl)lat=\(location.lat)&lon=\(location.lon)&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService.get(url: url, returnType: WeatherReport.self)

      switch result {
         case let .success(weatherData):
            weatherReport = weatherData
            do {
               let data = try JSONEncoder().encode(location)
               UserDefaults.standard.set(data, forKey: Constants.lastSearchedLocationKey)
            } catch {
               analytics.logError(error: error)
            }
         case let .failure(error):
            analytics.logError(error: error)
      }
   }
}
