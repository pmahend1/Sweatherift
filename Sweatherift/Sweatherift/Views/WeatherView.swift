//
//  WeatherView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import SwiftUI

struct WeatherView: View {
   @StateObject private var viewModel: WeatherViewModel

   init(for location: Location) {
      _viewModel = StateObject(wrappedValue: .init(for: location))
   }

   var body: some View {
      ZStack(alignment: .center) {
         if viewModel.isBusy {
            ProgressView()
               .ignoresSafeArea(.all)
         }
         VStack(alignment: .center, spacing: .zero) {
            if let weatherReport = viewModel.weatherReport {
               Text("\(weatherReport.name)")
                  .font(.title)

               if let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherReport.weather[0].icon)@2x.png") {
                  AsyncImage(url: iconUrl)
                     .scaledToFit()
               }
               Group {
                  Text("Temp: \(viewModel.convertTemperature(temp: weatherReport.main.temp))")
                  Text("Feels Like: \(viewModel.convertTemperature(temp: weatherReport.main.feelsLike))")
                  Text("Min: \(viewModel.convertTemperature(temp: weatherReport.main.minTemp))")
                  Text("Max: \(viewModel.convertTemperature(temp: weatherReport.main.maxTemp))")
               }

               Group {
                  Text("Pressure: \(weatherReport.main.pressure)mbar")
                  Text("Humidity: \(weatherReport.main.humidity.formatted(.percent))")
               }

               Group {
                  Text("Clouds")
                     .font(.title3)

                  Text("\(weatherReport.clouds.all.formatted(.percent))")
               }
               .padding(.top, 20)

               Group {
                  Text("Wind")
                     .font(.title3)

                  Text("Speed: \(weatherReport.wind.speed)km/h")
                  Text("Degree: \(weatherReport.wind.deg)°")
               }
               .padding(.top, 20)
            }
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
