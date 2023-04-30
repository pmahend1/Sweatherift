//
//  AnaltyicsServiceMock.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation
@testable import Sweatherift

class AnaltyicsServiceMock: AnalyticsProtocol {
   // MARK: - Mock Properties
   var wasLogErrorCalled = false

   // MARK: - Implementation

   func logError(error: Error, properties: [String: String]) {
      wasLogErrorCalled = true
   }
}
