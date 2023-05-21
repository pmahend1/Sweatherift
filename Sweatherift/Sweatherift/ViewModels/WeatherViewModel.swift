//
//  WeatherViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import CoreLocation
import Foundation

@MainActor
final class WeatherViewModel: ObservableObject {
   // MARK: - Properties

   @Published var weatherReport: WeatherReport? = nil
   @Published var isBusy = false
   @Published var showError = false

   @Injected(\.weatherRepository) var weatherRepository
   @Injected(\.analytics) var analytics

   var location: Location?
   var coOrdinates: CLLocationCoordinate2D?

   var title: String {
      if let location = location {
         var stateText = ""
         if let state = location.state {
            stateText = ", \(state)"
         }
         return "\(location.name)\(stateText), \(location.country)"
      } else {
         return "My Location"
      }
   }

   // MARK: - Init

   init(for location: Location) {
      self.location = location
   }

   init(for coOrdinates: CLLocationCoordinate2D) {
      self.coOrdinates = coOrdinates
   }

   // MARK: - Methods

   func getWeather() async {
      defer {
         isBusy = false
      }
      isBusy = true

      var lat = 0.0
      var lon = 0.0

      if let location = location {
         lat = location.lat
         lon = location.lon
      } else if let coOrdinates = coOrdinates {
         lat = coOrdinates.latitude
         lon = coOrdinates.longitude
      } else {
         return
      }

      let result = await weatherRepository.getWeatherByLatLon(lat: lat, lon: lon, useCache: true)

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
            showError = true
      }
   }
}
