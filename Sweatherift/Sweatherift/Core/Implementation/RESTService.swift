//
//  RESTService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

class RESTService: RESTProtocol {
   func get(url: String) async -> Result<Data, Error> {
      let urlOptional = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
      guard let urlString = urlOptional, let url = URL(string: urlString) else {
         return Result.failure(APIError(message: "Invalid URL"))
      }

      do {
         let (data, _) = try await URLSession.shared.data(from: url)
         return Result.success(data)
      } catch {
         return Result.failure(error)
      }
   }
}
