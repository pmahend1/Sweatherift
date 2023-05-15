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
            .navigationDestination(isPresented: $viewModel.isLocationShared) {
               if let location = locationManager.location {
                  WeatherView(for: location)
               }
            }
            .navigationDestination(isPresented: $viewModel.showAPIView) {
               APIKeyInputView()
            }
            .navigationTitle("Sweatherift")
         }
         .padding(.horizontal, 20)

         if viewModel.searchText.isEmpty {
            LocationButton(.shareMyCurrentLocation) {
               locationManager.requestLocation()
               viewModel.isLocationShared = true
            }
            .frame(height: 40)
            .foregroundColor(.primary)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .padding(.top, 10)

            if locationManager.location != nil {
               Text(Localized.locationSharedMessage)
                  .font(.caption)
            }

            if !viewModel.isKeyPresent {
               Text("You don't have API key stored. Please securely store for API calls.")
            }
            let buttonText = viewModel.isKeyPresent ? "Change API Key" : "Save API Key"
            Button(buttonText) {
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
