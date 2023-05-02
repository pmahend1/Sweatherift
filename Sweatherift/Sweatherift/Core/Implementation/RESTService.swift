//
//  RESTService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 4/28/23.
//

import Foundation

class RESTService: RESTProtocol {
   func get<T: Decodable>(url: String, returnType: T.Type) async -> Result<T, Error> {
      let urlOptional = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) //converts space to %20
      guard let urlString = urlOptional, let url = URL(string: urlString) else {
         return .failure(AppError(message: "Invalid URL"))
      }

      do {
         let jsonDecoder = JSONDecoder()
         jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

         let (data, _) = try await URLSession.shared.data(from: url)
         let decodedData = try jsonDecoder.decode(returnType.self, from: data)
         return .success(decodedData)
      } catch {
         return .failure(error)
      }
   }
}
