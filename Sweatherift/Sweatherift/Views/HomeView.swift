//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//


import SwiftUI
import CoreLocationUI

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
         List {
            LocationButton(.shareMyCurrentLocation) {
               locationManager.requestLocation()
               viewModel.isLocationShared = true
            }
            .frame(height: 44)
            .padding()

            if let location = locationManager.location {
               Text("Your location: \(location.latitude), \(location.longitude)")
            }

            ForEach(searchResults, id: \.id) { location in
               NavigationLink(value: location) {
                  Text("\(location.name)\(location.state == nil ? "" : ",\(location.state ?? "")"), \(location.country)")
               }
            }
         }
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
               let loc = Location(name: "",
                                  lat: location.latitude,
                                  lon: location.longitude,
                                  country: "",
                                  state: "")
               WeatherView(for: loc)
            }
         }
         .navigationTitle("Sweatherift")
      }
      .searchable(text: $viewModel.searchText)
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

