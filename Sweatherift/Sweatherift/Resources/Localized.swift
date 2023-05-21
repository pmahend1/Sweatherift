//
//  LocalizedString.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

enum Localized {
   static let apiKeyNotPresent = String(localized: "apiKeyNotPresent", comment: "You don't have API key stored. Please securely store for API calls.")
   static let change = String(localized: "change", comment: "Change")
   static let changeAPIKey = String(localized: "changeAPIKey", comment: "Change API Key")
   static let currentAPIKey = String(localized: "currentAPIKey", comment: "Current API Key")
   static let enterKey = String(localized: "enterKey", comment: "Enter Key")
   static let genericErrorMessage = String(localized: "genericErrorMessage", comment: "Something went wrong! Please try again later.")
   static let goToHttpsHomeOpenweathermapOrgApiKeysToGetAKey = String(localized: "goToOpenweathermapOrgApiKeysToGetAKey", comment: "Go to [https://home.openweathermap.org/api_keys](https://home.openweathermap.org/api_keys) to get a key")
   static let key = String(localized: "key", comment: "Key")
   static let locationSharedMessage = String(localized: "locationSharedMessage", comment: "You have shared your location.")
   static let myLocation = String(localized: "myLocation", comment: "My Location")
   static let noWeatherReportFound = String(localized: "noWeatherReportFound", comment: "No weather report found. Please try again later!")
   static let registerAtHttpsOpenweathermapOrg = String(localized: "registerAtOpenweathermapOrg", comment: "Register at [https://openweathermap.org](https://openweathermap.org)")
   static let save = String(localized: "save", comment: "Save")
   static let saveAPIKey = String(localized: "saveAPIKey", comment: "Save API Key")
   static let searchDescription = String(localized: "searchDescription", comment: "Enter at least 3 characters to begin search or share your location.")
   static let show = String(localized: "show", comment: "Show")
   static let wind = String(localized: "wind", comment: "Wind")
   
   static func temperatureFormat(_ temp: String) -> String {
      return String(localized: "temperature:\(temp)")
   }

   static func feelsLikeFormat(_ temp: String) -> String {
      return String(localized: "feelsLike:\(temp)")
   }

   static func minTempFormat(_ temp: String) -> String {
      return String(localized: "min:\(temp)")
   }

   static func maxTempFormat(_ temp: String) -> String {
      return String(localized: "max:\(temp)")
   }

   static func pressureFormat(_ pressure: Int) -> String {
      return String(localized: "pressure:\(pressure)")
   }

   static func speedFormat(_ speed: String) -> String {
      return String(localized: "speed:\(speed)")
   }

   static func degreeFormat(_ degree: Int) -> String {
      return String(localized: "degree:\(degree)")
   }

   static func humidityFormat(_ humidityString: String) -> String {
      return String(localized: "humidity:\(humidityString)")
   }

   static func cloudsFormat(_ cloudsPercentage: String) -> String {
      return String(localized: "clouds:\(cloudsPercentage)")
   }
}
