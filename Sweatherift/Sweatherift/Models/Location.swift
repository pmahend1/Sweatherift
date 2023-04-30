//
//  Location.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import Foundation

struct Location: Decodable, Identifiable {
   let id = UUID()
   let name: String
   let localNames: [String: String]?
   let lat: Double
   let lon: Double
   let country: String
   let state: String?

   enum CodingKeys: CodingKey {
      case name
      case localNames
      case lat
      case lon
      case country
      case state
   }

   init(name: String,
        localNames: [String: String]? = nil,
        lat: Double,
        lon: Double,
        country: String,
        state: String)
   {
      self.name = name
      self.localNames = localNames
      self.lat = lat
      self.lon = lon
      self.country = country
      self.state = state
   }
}
