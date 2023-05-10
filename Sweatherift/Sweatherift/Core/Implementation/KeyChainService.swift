//
//  KeyChainService.swift
//  Sweatherift
//
//  Created by Prateek Mahendrakar on 5/9/23.
//

import Foundation

final class KeyChainService: KeyChainProtocol {
   static let standard = KeyChainService()
   private init() {}

   func save<T>(_ item: T, service: String, account: String) where T: Decodable, T: Encodable {
      do {
         // Encode as JSON data and save in keychain
         let data = try JSONEncoder().encode(item)
         save(data, service: service, account: account)

      } catch {
         assertionFailure("Fail to encode item for keychain: \(error)")
      }
   }

   func read<T>(service: String, account: String, type: T.Type) -> T? where T: Decodable, T: Encodable {
      // Read item data from keychain
      guard let data = read(service: service, account: account) else {
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

   func delete(service: String, account: String) {
      let query = [
         kSecAttrService: service,
         kSecAttrAccount: account,
         kSecClass: kSecClassGenericPassword,
      ] as [CFString: Any] as CFDictionary

      // Delete item from keychain
      SecItemDelete(query)
   }

   func save(_ data: Data, service: String, account: String) {
      // Create query
      let query = [
         kSecValueData: data,
         kSecClass: kSecClassGenericPassword,
         kSecAttrService: service,
         kSecAttrAccount: account,
      ] as CFDictionary

      // Add data in query to keychain
      let status = SecItemAdd(query, nil)

      if status != errSecSuccess {
         // Print out the error
         print("Error: \(status)")
      }
   }

   func read(service: String, account: String) -> Data? {
      let query = [
         kSecAttrService: service,
         kSecAttrAccount: account,
         kSecClass: kSecClassGenericPassword,
         kSecReturnData: true,
      ] as CFDictionary

      var result: AnyObject?
      SecItemCopyMatching(query, &result)

      return result as? Data
   }
}
