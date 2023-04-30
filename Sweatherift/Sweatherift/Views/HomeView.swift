//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import CoreLocation
import CoreLocationUI
import SwiftUI

struct HomeView: View {
   @StateObject private var viewModel = HomeViewModel()
   @StateObject var locationManager = LocationManager()
   @State private var searchText = ""
   @State private var lastLocation: Location?
   @State private var isLastDisplayed = false
   @State private var isLocationShared = false

   var searchResults: [Location] {
      if searchText.isEmpty || searchText.count < 3 {
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
               isLocationShared = true
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
         .navigationDestination(isPresented: $isLastDisplayed) {
            if let location = lastLocation {
               WeatherView(for: location)
            }
         }
         .navigationDestination(isPresented: $isLocationShared) {
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
      .searchable(text: $searchText)
      .onChange(of: searchText) { newValue in
         Task {
            await viewModel.getLocations(searchText: newValue)
         }
      }
      .onAppear {
         loadData()
         isLocationShared = locationManager.hasLocation
      }
   }

   // TODO: - move to viewModel
   func loadData() {
      let locationDataOptional = UserDefaults.standard.data(forKey: "lastSearchedLocation")
      if let locationData = locationDataOptional {
         do {
            let location = try JSONDecoder().decode(Location.self, from: locationData)
            lastLocation = location
            isLastDisplayed = true
         } catch {
            print(error)
         }
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
   let manager = CLLocationManager()

   @Published var location: CLLocationCoordinate2D?
   var hasLocation: Bool {
      return location != nil
   }

   override init() {
      super.init()
      manager.delegate = self
   }

   func requestLocation() {
      manager.requestLocation()
   }

   func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
      location = locations.first?.coordinate
   }

   func locationManager(_: CLLocationManager, didFailWithError error: Error) {
      print(error)
   }
}
