//
//  LocalizedString.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

enum Localized {
   static let searchDescription = String(localized: "searchDescription", comment: "Enter at least 3 characters to begin search or share your location.")
   static let locationSharedMessage = String(localized: "locationSharedMessage", comment: "You have shared your location.")
   static let wind = String(localized: "wind", comment: "Wind")
   static let noWeatherReportFound = String(localized: "noWeatherReportFound", comment: "No weather report found. Please try again later!")

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
