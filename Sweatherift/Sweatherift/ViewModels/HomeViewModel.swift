//
//  HomeViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
   // MARK: - Properties

   @Published var cityName = ""
   @Published var weatherReport: WeatherReport? = nil

   // MARK: - Methods

   func getWeather(location: String) async {
      let url = "\(Constants.weatherUrl)\(location)&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService().get(url: url)
      switch result {
      case let .success(success):
         let jsonDecoder = JSONDecoder()
         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

         do {
            let data = try jsonDecoder.decode(WeatherReport.self, from: success)
            weatherReport = data
         } catch {
            print(String(describing: error))
         }
      case let .failure(failure):
         print(failure)
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
