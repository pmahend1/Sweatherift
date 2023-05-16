//
//  HomeViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
   // MARK: - Published Properties

   @Published var cityName = ""
   @Published var locationResults: [Location] = []
   @Published var searchText = ""
   @Published var lastLocation: Location?
   @Published var isLastDisplayed = false
   @Published var isLocationShared = false
   @Published var showAPIView = false
   @Published var isKeyPresent = false

   // MARK: - Injected Properties

   @Injected(\.weatherRepository) var weatherRepository
   @Injected(\.analytics) var analytics
   @Injected(\.keyChainService) var keyChainService

   // MARK: - Methods

   func getLocations(searchText: String) async {
      let result = await weatherRepository.searchLocations(searchTerm: searchText, useCache: true)
      switch result {
         case let .success(data):
            locationResults = data
         case let .failure(error):
            analytics.logError(error: error)
      }
   }

   func loadData() {
      if let weatherApiKey = keyChainService.read(key: Constants.weatherAPIKey, type: String.self) {
         keyChainService.keyValues[Constants.weatherAPIKey] = weatherApiKey
         isKeyPresent = true
      } else {
         showAPIView = true
         return
      }

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
