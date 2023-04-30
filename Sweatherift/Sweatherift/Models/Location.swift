//
//  Location.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/29/23.
//

import Foundation

struct Location: Decodable, Identifiable {
   var id = UUID()
   let name: String
   let localNames: [String: String]?
   let lat: Double
   let lon: Double
   let country: String
   let state: String

   enum CodingKeys: CodingKey {
      case name
      case localNames
      case lat
      case lon
      case country
      case state
   }
}
