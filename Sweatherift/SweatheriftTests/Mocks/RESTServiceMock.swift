//
//  RESTServiceMock.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation
@testable import Sweatherift

class RESTServiceMock: RESTProtocol {
   // MARK: - Mock Properties

   var shouldError = false
   var error = APIError(message: "Error thrown from mock.")
   var returnableObject: Any? = nil

   func get<T>(url _: String, returnType _: T.Type) async -> Result<T, Error> where T: Decodable {
      guard !shouldError else {
         return .failure(error)
      }
      if let returnObject = returnableObject as? T {
         return .success(returnObject)
      } else {
         return .failure(error)
      }
   }
}
