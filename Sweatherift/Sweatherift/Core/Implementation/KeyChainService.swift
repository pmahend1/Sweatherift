//
//  KeyChainService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/9/23.
//

import Foundation

final class KeyChainService: KeyChainProtocol {
   static let standard = KeyChainService()
   let account = "Sweatherift"

   var keyValues: [String: Codable] = [:]
   private init() {}

   func save<T>(_ item: T, key: String) where T: Decodable, T: Encodable {
      do {
         // Encode as JSON data and save in keychain
         let data = try JSONEncoder().encode(item)
         save(data, key: key)

      } catch {
         assertionFailure("Fail to encode item for keychain: \(error)")
      }
   }

   func read<T>(key: String, type: T.Type) -> T? where T: Decodable, T: Encodable {
      // Read item data from keychain
      guard let data = read(key: key) else {
         return nil
      }

      // Decode JSON data to object
      do {
         let item = try JSONDecoder().decode(type, from: data)
         return item
      } catch {
         assertionFailure("Fail to decode item for keychain: \(error)")
         return nil
      }
   }

   func delete(key: String) {
      let query = [
         kSecAttrService: key,
         kSecAttrAccount: account,
         kSecClass: kSecClassGenericPassword,
      ] as [CFString: Any] as CFDictionary

      // Delete item from keychain
      SecItemDelete(query)
   }

   func save(_ data: Data, key: String) {
      // Create query
      let query = [
         kSecValueData: data,
         kSecClass: kSecClassGenericPassword,
         kSecAttrService: key,
         kSecAttrAccount: account,
      ] as [CFString: Any] as CFDictionary

      // Add data in query to keychain
      let status = SecItemAdd(query, nil)

      if status != errSecSuccess {
         // Print out the error
         print("Error: \(status)")
      }
   }

   func read(key: String) -> Data? {
      let query = [
         kSecAttrService: key,
         kSecAttrAccount: account,
         kSecClass: kSecClassGenericPassword,
         kSecReturnData: true,
      ] as [CFString: Any] as CFDictionary

      var result: AnyObject?
      SecItemCopyMatching(query, &result)

      return result as? Data
   }
}
