//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Combine
import CoreLocationUI
import SwiftUI

struct HomeView: View {
   // MARK: - Properties

   @StateObject private var viewModel = HomeViewModel()
   @StateObject var locationManager = LocationManager()
   let APIKeyChangedPublisher = NotificationCenter.default.publisher(for: Notification.APIKeyChanged)

   var searchResults: [Location] {
      if viewModel.searchText.isEmpty || viewModel.searchText.count < 3 {
         return []
      } else {
         return viewModel.locationResults
      }
   }

   // MARK: - Body

   var body: some View {
      NavigationStack {
         VStack(spacing: .zero) {
            if viewModel.searchText.isEmpty {
               Text(Localized.searchDescription)
                  .font(.callout)
            }

            List {
               ForEach(searchResults, id: \.id) { location in
                  NavigationLink(value: location) {
                     Text("\(location.name)\(location.state == nil ? "" : ",\(location.state ?? "")"), \(location.country)")
                  }
               }
            }
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: Location.self) { location in
               WeatherView(for: location)
            }
            .navigationDestination(isPresented: $viewModel.isLastDisplayed) {
               if let location = viewModel.lastLocation {
                  WeatherView(for: location)
               }
            }
            .navigationDestination(isPresented: $viewModel.showCurrentLocationWeather) {
               if let location = locationManager.location {
                  WeatherView(for: location)
               }
            }
            .navigationDestination(isPresented: $viewModel.showAPIView) {
               APIKeyInputView()
            }

            if viewModel.searchText.isEmpty {
               if locationManager.location == nil {
                  LocationButton(.shareMyCurrentLocation) {
                     locationManager.requestLocation()
                  }
                  .frame(height: 40)
                  .foregroundColor(.primary)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .padding(.top, 10)
               } else {
                  Button("Get Weather for my location") {
                     viewModel.showCurrentLocationWeather = true
                  }
                  .font(.body.bold())
                  .frame(width: 350, height: 40)
                  .background(Color.accentColor)
                  .foregroundColor(.primary)
                  .clipShape(RoundedRectangle(cornerRadius: 10))
                  .padding(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
               }

               if locationManager.location != nil {
                  Text(Localized.locationSharedMessage)
                     .font(.caption)
                     .padding(.top, 5)
               }

               if !viewModel.isKeyPresent {
                  Text(Localized.apiKeyNotPresent)
               }

               Button(viewModel.isKeyPresent ? Localized.changeAPIKey : Localized.changeAPIKey) {
                  viewModel.showAPIView = true
               }
               .font(.body.bold())
               .frame(width: 200, height: 40)
               .background(Color.accentColor)
               .foregroundColor(.primary)
               .clipShape(RoundedRectangle(cornerRadius: 10))
               .padding(EdgeInsets(top: 10, leading: 0, bottom: 20, trailing: 0))
            }
         }
         .padding(.horizontal, 20)
         .onChange(of: viewModel.searchText) { newValue in
            Task {
               await viewModel.getLocations(searchText: newValue)
            }
         }
         .onAppear {
            viewModel.loadData()
            viewModel.showCurrentLocationWeather = locationManager.hasLocation
         }
         .onReceive(APIKeyChangedPublisher) { _ in
            viewModel.loadData()
         }
         .navigationTitle("Sweatherift")
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
