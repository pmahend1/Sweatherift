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

   // MARK: - Methods

   func getWeather(for location: Location) async {
      let url = "\(Constants.weatherUrl)lat=\(location.lat)&lon=\(location.lon)&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService().get(url: url)
      switch result {
         case let .success(data):
            let jsonDecoder = JSONDecoder()
            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

            do {
               let weatherData = try jsonDecoder.decode(WeatherReport.self, from: data)
               weatherReport = weatherData
            } catch {
               print(String(describing: error))
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
