//
//  APIKeyInputViewModel.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/14/23.
//

import Foundation

class APIKeyInputViewModel: ObservableObject {
   // MARK: - Properties

   @Published var text: String = ""
   @Published var showAPIKey = false
   @Published var showKeyUpdatedMessage = false
   @Published var APIKey: String = ""

   @Injected(\.keyChainService) var keyChainService

   var isKeyPresent: Bool {
      if let apiKey = keyChainService.keyValues[Constants.weatherAPIKey] as? String {
         if !apiKey.isEmpty {
            return true
         }
      }
      return false
   }

   // MARK: - Methods

   func save() -> Bool {
      guard !text.isEmpty else { return false }

      keyChainService.save(text, key: Constants.weatherAPIKey)
      keyChainService.keyValues[Constants.weatherAPIKey] = text
      showKeyUpdatedMessage = true
      APIKey = text
      NotificationCenter.default.post(name: Notification.APIKeyChanged, object: nil)
      return true
   }

   func loadData() {
      guard let apiKey = keyChainService.keyValues[Constants.weatherAPIKey] as? String else { return }
      APIKey = apiKey
   }
}
