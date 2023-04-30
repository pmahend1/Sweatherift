//
//  AnalyticsProtocol.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

protocol AnalyticsProtocol {
   func logError(error: Error, properties: [String: String])
}

extension AnalyticsProtocol {
   func logError(error: Error, properties: [String: String] = [:]) {
      logError(error: error, properties: properties)
   }
}
