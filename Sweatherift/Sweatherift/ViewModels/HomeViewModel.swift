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

   // MARK: - Methods

   

   func getLocations(searchText: String) async {
      let url = "\(Constants.locationUrl)\(searchText)&limit=5&APPID=\(Constants.weatherAPIKey)"
      let result = await RESTService().get(url: url)
      switch result {
      case let .success(success):
         let jsonDecoder = JSONDecoder()
         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

         do {
            let data = try jsonDecoder.decode([Location].self, from: success)
            locationResults = data
         } catch {
            print(String(describing: error))
         }
      case let .failure(failure):
         print(failure)
      }
   }
}
