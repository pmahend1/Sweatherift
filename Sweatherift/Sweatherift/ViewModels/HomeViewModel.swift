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

   @Injected(\.RESTService) var RESTService

   // MARK: - Methods

   func getLocations(searchText: String) async {
      let url = "\(Constants.locationUrl)\(searchText)&limit=5&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService.get(url: url, returnType: [Location].self)
      switch result {
         case let .success(data):
            locationResults = data
         case let .failure(failure):
            print(failure)
      }
   }
}
