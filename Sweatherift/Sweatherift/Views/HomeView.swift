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
   // MARK: - Body

   var body: some View {
      NavigationStack {
         List {
            ForEach(searchResults, id: \.id) { location in
               NavigationLink {
                  //Text("\(location.name),\(location.state),\(location.country)")
                  WeatherView()
               } label: {
                  Text("\(location.name),\(location.state),\(location.country)")
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
   }

   var searchResults: [Location] {
      if searchText.isEmpty || searchText.count < 3 {
         return []
      } else {
         return viewModel.locationResults // .map { $0.name }
      }
   }
}

struct HomeView_Previews: PreviewProvider {
   static var previews: some View {
      HomeView()
   }
}
