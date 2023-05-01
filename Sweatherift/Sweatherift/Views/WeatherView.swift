//
//  WeatherView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import SwiftUI
import CoreLocation

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
                  Text("\(weatherReport.name)")
                     .font(.title)

                  let currentWeather = weatherReport.weather[0]
                  if let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(currentWeather.icon)@2x.png") {
                     AsyncImage(url: iconUrl)
                        .scaledToFit()
                  }
                  Group {
                     Text("\(currentWeather.main) - \(currentWeather.description)")
                        .padding(.top, 20)
                     Text("Temp: \(Converter.toLocaleTemperature(weatherReport.main.temp))")
                        .padding(.top, 10)
                     Text("Feels Like: \(Converter.toLocaleTemperature(weatherReport.main.feelsLike))")
                     Text("Min: \(Converter.toLocaleTemperature(weatherReport.main.minTemp))")
                     Text("Max: \(Converter.toLocaleTemperature(weatherReport.main.maxTemp))")
                  }

                  Group {
                     Text("Pressure: \(weatherReport.main.pressure)mbar")
                        .padding(.top, 20)
                     Text("Humidity: \(weatherReport.main.humidity.formatted(.percent))")
                     Text("Clouds: \(weatherReport.clouds.all.formatted(.percent))")
                  }

                  Group {
                     Text("Wind")
                        .font(.title3)
                        .padding(.top, 20)

                     Text("Speed: \(weatherReport.wind.speed.formatted())km/h")
                     Text("Degree: \(weatherReport.wind.deg)°")
                  }
               } else {
                  Text("No weather report found. Please try again later!")
               }
            }
            .padding(.all, 20)
         }
      }
      .task {
         await viewModel.getWeather()
      }
      .navigationTitle(viewModel.title )
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
