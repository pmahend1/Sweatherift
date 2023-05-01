//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import CoreLocationUI
import SwiftUI

struct HomeView: View {
   // MARK: - Properties

   @StateObject private var viewModel = HomeViewModel()
   @StateObject var locationManager = LocationManager()

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
            Text("Enter at least 3 characters to begin search or share your location")
               .font(.callout)

            LocationButton(.shareMyCurrentLocation) {
               locationManager.requestLocation()
               viewModel.isLocationShared = true
            }
            .frame(height: 44)
            .padding(.top, 10)

            if locationManager.location != nil {
               Text("You have shared your location")
                  .font(.caption)
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
            .navigationDestination(isPresented: $viewModel.isLocationShared) {
               if let location = locationManager.location {
                  WeatherView(for: location)
               }
            }
            .navigationTitle("Sweatherift")
         }
         .padding(.horizontal, 20)
      }

      .onChange(of: viewModel.searchText) { newValue in
         Task {
            await viewModel.getLocations(searchText: newValue)
         }
      }
      .onAppear {
         viewModel.loadData()
         viewModel.isLocationShared = locationManager.hasLocation
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
