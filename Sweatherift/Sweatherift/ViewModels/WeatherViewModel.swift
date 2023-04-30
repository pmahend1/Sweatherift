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

      let url = "\(Constants.weatherUrl)lat=\(location.lat)&lon=\(location.lon)&APPID=\(Constants.weatherAPIKey)"

      isBusy = true
      let result = await RESTService.get(url: url, returnType: WeatherReport.self)
      switch result {
         case let .success(weatherData):
            weatherReport = weatherData
            do {
               let data = try JSONEncoder().encode(location)
               UserDefaults.standard.set(data, forKey: "lastSearchedLocation")
            } catch {
               print(error)
            }
         case let .failure(error):
            print(error)
      }
   }

   func convertTemperature(temp: Double) -> String {
      let mf = MeasurementFormatter()
      mf.locale = .current
      mf.numberFormatter.maximumFractionDigits = 0
      let input = Measurement(value: temp, unit: UnitTemperature.kelvin)
      return mf.string(from: input)
   }
}
