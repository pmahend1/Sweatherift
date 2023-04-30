//
//  HomeViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
   // MARK: - Properties

   @Published var cityName = ""
   @Published var locationResults: [Location] = []
   @Published var searchText = ""
   @Published var lastLocation: Location?
   @Published var isLastDisplayed = false
   @Published var isLocationShared = false

   @Injected(\.RESTService) var RESTService
   @Injected(\.analytics) var analytics

   // MARK: - Methods

   func getLocations(searchText: String) async {
      let url = "\(Constants.locationUrl)\(searchText)&limit=5&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService.get(url: url, returnType: [Location].self)
      switch result {
         case let .success(data):
            locationResults = data
         case let .failure(error):
            analytics.logError(error: error)
      }
   }

   func loadData() {
      let locationDataOptional = UserDefaults.standard.data(forKey: Constants.lastSearchedLocationKey)
      if let locationData = locationDataOptional {
         do {
            let location = try JSONDecoder().decode(Location.self, from: locationData)
            lastLocation = location
            isLastDisplayed = true
         } catch {
            analytics.logError(error: error)
         }
      }
   }
}
