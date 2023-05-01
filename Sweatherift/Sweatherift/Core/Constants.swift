//
//  Constants.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

enum Constants {
   static let locationNameUrl = "https://api.openweathermap.org/geo/1.0/direct?q="

   static let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?"
   static let weatherAPIKey = "22d8451191cd2184aa1df845efe8e52f"
   static let lastSearchedLocationKey = "lastSearchedLocation"

   static func locationLatLonUrl(lat: Double, lon: Double) -> String {
      return "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(weatherAPIKey)"
   }
}
