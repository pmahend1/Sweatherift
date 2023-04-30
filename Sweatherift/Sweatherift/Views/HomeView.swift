//
//  HomeView.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import SwiftUI

struct HomeView: View {
   @StateObject private var viewModel = HomeViewModel()
   @State private var searchText = ""
   @State private var lastLocation: Location?

   // MARK: - Body

   var body: some View {
      NavigationStack {
         List {
            ForEach(searchResults, id: \.id) { location in
               NavigationLink {
                  WeatherView(for: location)
               } label: {
                  Text("\(location.name)\(location.state == nil ? "" : ",\(location.state ?? "")"), \(location.country)")
               }
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
      }
      .background {
         NavigationLink(value: lastLocation) {
            if let location = lastLocation {
               WeatherView(for: location)
            }
         }.opacity(0)
      }
   }

   var searchResults: [Location] {
      if searchText.isEmpty || searchText.count < 3 {
         return []
      } else {
         return viewModel.locationResults
      }
   }

   func loadData() {
      let locationDataOptional = UserDefaults.standard.data(forKey: "lastSearchedLocation")
      if let locationData = locationDataOptional {
         do {
            let location = try JSONDecoder().decode(Location.self, from: locationData)
            lastLocation = location
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
