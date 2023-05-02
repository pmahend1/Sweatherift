//
//  Constants.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

enum Constants {
   static let locationNameURL = "https://api.openweathermap.org/geo/1.0/direct?q="

   static let weatherURL = "https://api.openweathermap.org/data/2.5/weather?"
   static let weatherAPIKey = "22d8451191cd2184aa1df845efe8e52f"
   static let lastSearchedLocationKey = "lastSearchedLocation"

   static func locationLatLonURL(lat: Double, lon: Double) -> String {
      return "https://api.openweathermap.org/geo/1.0/reverse?lat=\(lat)&lon=\(lon)&limit=1&appid=\(weatherAPIKey)"
   }

   static func iconURL(icon: String) -> String {
      return "https://openweathermap.org/img/wn/\(icon)@2x.png"
   }
}
