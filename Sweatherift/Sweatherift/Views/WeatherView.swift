//
//  WeatherView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import SwiftUI

struct WeatherView: View {
   @StateObject private var viewModel = WeatherViewModel()

   var body: some View {
      if let weatherReport = viewModel.weatherReport {
         Text("\(weatherReport.name)")
            .font(.title)

         if let iconUrl = URL(string: "https://openweathermap.org/img/wn/\(weatherReport.weather[0].icon)@2x.png") {
            AsyncImage(url: iconUrl)
               .scaledToFit()
         }

         Text("Temp: \(viewModel.convertTemperature(temp: weatherReport.main.temp))")
         Text("Feels Like: \(viewModel.convertTemperature(temp: weatherReport.main.feelsLike))")
         Text("Min: \(viewModel.convertTemperature(temp: weatherReport.main.minTemp))")
         Text("Max: \(viewModel.convertTemperature(temp: weatherReport.main.maxTemp))")

         Text("Pressure: \(weatherReport.main.pressure)")
         Text("Humidity: \(weatherReport.main.humidity.formatted(.percent))")
      }
   }
}

struct WeatherView_Previews: PreviewProvider {
   static var previews: some View {
      WeatherView()
   }
}
