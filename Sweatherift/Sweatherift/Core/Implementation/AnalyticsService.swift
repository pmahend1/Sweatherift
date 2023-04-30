//
//  AnalyticsService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct AnalyticsService: AnalyticsProtocol {
   func logError(error: Error, properties: [String: String]) {
      print(error)
      properties.forEach { k, v in
         print("\t\(k): \(v)")
      }
   }
}
