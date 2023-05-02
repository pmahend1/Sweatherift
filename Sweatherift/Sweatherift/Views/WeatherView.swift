//
//  WeatherView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import CoreLocation
import SwiftUI

struct WeatherView: View {
   @StateObject private var viewModel: WeatherViewModel

   init(for location: Location) {
      _viewModel = StateObject(wrappedValue: .init(for: location))
   }

   init(for coOrdinates: CLLocationCoordinate2D) {
      _viewModel = StateObject(wrappedValue: .init(for: coOrdinates))
   }

   var body: some View {
      ZStack(alignment: .center) {
         if viewModel.isBusy {
            ProgressView()
               .ignoresSafeArea(.all)
         } else {
            VStack(alignment: .center, spacing: .zero) {
               if let weatherReport = viewModel.weatherReport, weatherReport.weather.count > 0 {
                  Text(weatherReport.name)
                     .font(.title)
                  Text(weatherReport.system.country)
                     .font(.body)

                  let currentWeather = weatherReport.weather[0]
                  if let iconURL = URL(string: Constants.iconURL(icon: currentWeather.icon)) {
                     CachedAsyncImageView(url: iconURL)
                  }
                  Group {
                     Text("\(currentWeather.main) - \(currentWeather.description)")
                        .padding(.top, 20)
                     Text(Localized.temperatureFormat(Converter.toLocaleTemperature(weatherReport.main.temp)))
                        .padding(.top, 10)
                     Text(Localized.feelsLikeFormat(Converter.toLocaleTemperature(weatherReport.main.feelsLike)))
                     Text(Localized.minTempFormat(Converter.toLocaleTemperature(weatherReport.main.minTemp)))
                     Text(Localized.maxTempFormat(Converter.toLocaleTemperature(weatherReport.main.maxTemp)))
                  }

                  Group {
                     Text(Localized.pressureFormat(weatherReport.main.pressure))
                        .padding(.top, 20)
                     Text(Localized.humidityFormat(weatherReport.main.humidity.formatted(.percent)))
                     Text(Localized.cloudsFormat(weatherReport.clouds.all.formatted(.percent)))
                  }

                  Group {
                     Text(Localized.wind)
                        .font(.title3)
                        .padding(.top, 20)

                     Text(Localized.speedFormat(weatherReport.wind.speed.formatted()))
                     Text(Localized.degreeFormat(weatherReport.wind.deg))
                  }
               } else {
                  Text(Localized.noWeatherReportFound)
               }
            }
            .padding(.all, 20)
         }
      }
      .task {
         await viewModel.getWeather()
      }
      .navigationTitle(viewModel.title)
      .navigationBarTitleDisplayMode(.inline)
   }
}

struct WeatherView_Previews: PreviewProvider {
   static var previews: some View {
      WeatherView(for: Location(name: "Charlotte",
                                lat: 1.0,
                                lon: 1.0,
                                country: "US",
                                state: "NC"))
   }
}
