//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import SwiftUI

struct HomeView: View {
   @StateObject private var viewModel = HomeViewModel()
   // mar
   var body: some View {
      // NavigationView {
      VStack(alignment: .leading, spacing: .zero) {
         Text("Enter City")
            .font(.caption)
            .padding(.leading, 5)
         TextField("Enter City", text: $viewModel.cityName)
            .textFieldStyle(.roundedBorder)
            .padding(.top, 5)

         Button("Search") {
            Task { @MainActor in
               await viewModel.getWeather(location: viewModel.cityName)
            }
         }
         .buttonStyle(.borderedProminent)
         .padding(.top, 10)

         Spacer()

         if let weatherReport = viewModel.weatherReport {
            Text("\(weatherReport.name)")
               .font(.title)
//              Text("Lattitue: \(String(describing: weatherReport.coOrdinates.lat))")
//              Text("Longitude: \(String(describing: weatherReport.coOrdinates.lon))")

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
      .padding()
      .navigationTitle("Sweatherift")
      // }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
