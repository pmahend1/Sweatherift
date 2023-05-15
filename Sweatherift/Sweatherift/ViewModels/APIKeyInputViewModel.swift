//
//  APIKeyInputViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/14/23.
//

import Foundation

class APIKeyInputViewModel: ObservableObject {
   @Published var text: String = ""
   @Published var showAPIKey = false

   @Injected(\.keyChainService) var keyChainService

   func save() -> Bool {
      guard !text.isEmpty else { return false }
      keyChainService.save(text, key: Constants.weatherAPIKey)
      keyChainService.keyValues[Constants.weatherAPIKey] = text
      return true
   }
}
