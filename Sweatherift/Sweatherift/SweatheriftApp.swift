//
//  SweatheriftApp.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/27/23.
//

import SwiftUI

@main
struct SweatheriftApp: App {
   var body: some Scene {
      WindowGroup {
         let locationOptional: Location? = nil // UserDefaults.standard.object(forKey: "lastSearchedLocation") as? Location
         if let location = locationOptional {
            WeatherView(for: location)
         } else {
            HomeView()
         }
      }
   }
}
