//
//  Bundle+extension.swift
//  SweatheriftTests
//
//  Created by Prateek Mahendrakar on 4/30/23.
//

import Foundation

struct BundleError: Error {
   let message: String
}

extension Bundle {
   func decodeJSONResource<T>(_ file: String, withExtension: String = "json", returnType: T.Type) -> Result<T, Error> where T: Decodable {
      guard let url = url(forResource: file, withExtension: withExtension) else {
         return .failure(BundleError(message: "Failed to locate \(file) in bundle."))
      }

      guard let data = try? Data(contentsOf: url) else {
         return .failure(BundleError(message: "Failed to load \(file) from bundle."))
      }

      let decoder = JSONDecoder()
      decoder.keyDecodingStrategy = .convertFromSnakeCase

      guard let loaded = try? decoder.decode(T.self, from: data) else {
         return .failure(BundleError(message: "Failed to decode \(file) from bundle."))
      }

      return .success(loaded)
   }
}
